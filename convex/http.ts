import { httpRouter } from "convex/server";
import { httpAction } from "./_generated/server";
import { v } from "convex/values";
import { verifyPassword, createToken, validateToken, deleteToken } from "./auth";

const router = httpRouter();

// ── Auth ──

router.route({
  path: "/api/auth/login",
  method: "POST",
  handler: httpAction(async (ctx, request) => {
    const { password } = await request.json();
    if (!password || !verifyPassword(password)) {
      return new Response(JSON.stringify({ error: "Invalid password" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    const token = await createToken(ctx.db);
    return new Response(JSON.stringify({ token }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

router.route({
  path: "/api/auth/me",
  method: "GET",
  handler: httpAction(async (ctx, request) => {
    const auth = request.headers.get("Authorization");
    if (!auth || !auth.startsWith("Bearer ")) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    const token = auth.slice(7);
    const valid = await validateToken(ctx.db, token);
    if (!valid) {
      return new Response(JSON.stringify({ error: "Invalid or expired token" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    return new Response(JSON.stringify({ ok: true }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

router.route({
  path: "/api/auth/logout",
  method: "POST",
  handler: httpAction(async (ctx, request) => {
    const auth = request.headers.get("Authorization");
    if (auth && auth.startsWith("Bearer ")) {
      await deleteToken(ctx.db, auth.slice(7));
    }
    return new Response(JSON.stringify({ ok: true }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

// ── Guest CRUD ──

router.route({
  path: "/api/guests",
  method: "GET",
  handler: httpAction(async (ctx, request) => {
    const auth = request.headers.get("Authorization");
    if (!auth || !auth.startsWith("Bearer ") || !(await validateToken(ctx.db, auth.slice(7)))) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    const guests = await ctx.db.query("guests").collect();
    return new Response(JSON.stringify(guests), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

router.route({
  path: "/api/guest",
  method: "POST",
  handler: httpAction(async (ctx, request) => {
    const auth = request.headers.get("Authorization");
    if (!auth || !auth.startsWith("Bearer ") || !(await validateToken(ctx.db, auth.slice(7)))) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    const body = await request.json();
    const { action, guest_id, first_name, last_name, spouse_name, guest_type, max_party, phone, deadline, attendance } = body;

    if (action === "add_guest") {
      const id = await ctx.db.insert("guests", {
        first_name: first_name || "",
        last_name: last_name || "",
        spouse_name: spouse_name || undefined,
        guest_type: guest_type || "single",
        max_party: max_party || 1,
        phone: phone || undefined,
        deadline: deadline || "",
        attendance: attendance || "invited",
      });
      return new Response(JSON.stringify({ id }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    if (action === "update_guest") {
      if (!guest_id) {
        return new Response(JSON.stringify({ error: "Missing guest_id" }), {
          status: 400,
          headers: { "Content-Type": "application/json" },
        });
      }
      await ctx.db.patch(guest_id, {
        first_name: first_name || "",
        last_name: last_name || "",
        spouse_name: spouse_name || undefined,
        guest_type: guest_type || "single",
        max_party: max_party || 1,
        phone: phone || undefined,
        deadline: deadline || "",
        attendance: attendance || "invited",
      });
      return new Response(JSON.stringify({ ok: true }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    return new Response(JSON.stringify({ error: "Invalid action" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

router.route({
  path: "/api/guest/delete",
  method: "POST",
  handler: httpAction(async (ctx, request) => {
    const auth = request.headers.get("Authorization");
    if (!auth || !auth.startsWith("Bearer ") || !(await validateToken(ctx.db, auth.slice(7)))) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    const { guestId } = await request.json();
    if (!guestId) {
      return new Response(JSON.stringify({ error: "Missing guestId" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }
    await ctx.db.delete(guestId);
    return new Response(JSON.stringify({ ok: true }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

// ── RSVP (public) ──

router.route({
  path: "/api/rsvp",
  method: "POST",
  handler: httpAction(async (ctx, request) => {
    const body = await request.json();
    const {
      guest_id,
      first_name,
      last_name,
      email,
      phone,
      attendance,
      guest_type,
      party_names,
      song_request,
      message,
      submitted_at,
    } = body;

    if (!first_name || !attendance) {
      return new Response(
        JSON.stringify({ error: "Missing required fields" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // If guest_id is provided, update the existing guest record
    if (guest_id) {
      try {
        await ctx.db.patch(guest_id, {
          first_name,
          last_name: last_name || "",
          email: email || undefined,
          phone: phone || undefined,
          attendance,
          guest_type: guest_type || "single",
          song_request: song_request || undefined,
          message: message || undefined,
          submitted_at: submitted_at || new Date().toISOString(),
        });
      } catch {
        // Guest ID might not exist, create a new record
        const id = await ctx.db.insert("guests", {
          first_name,
          last_name: last_name || "",
          email: email || undefined,
          phone: phone || undefined,
          attendance,
          guest_type: guest_type || "single",
          max_party: 1,
          deadline: "",
          song_request: song_request || undefined,
          message: message || undefined,
          submitted_at: submitted_at || new Date().toISOString(),
        });
        return new Response(JSON.stringify({ id }), {
          status: 200,
          headers: { "Content-Type": "application/json" },
        });
      }
      return new Response(JSON.stringify({ ok: true }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    // No guest_id — create a new guest record
    const id = await ctx.db.insert("guests", {
      first_name,
      last_name: last_name || "",
      email: email || undefined,
      phone: phone || undefined,
      attendance,
      guest_type: guest_type || "single",
      max_party: 1,
      deadline: "",
      song_request: song_request || undefined,
      message: message || undefined,
      submitted_at: submitted_at || new Date().toISOString(),
    });

    return new Response(JSON.stringify({ id }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  }),
});

export default router;
