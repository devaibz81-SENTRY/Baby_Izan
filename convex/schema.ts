import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  guests: defineTable({
    first_name: v.string(),
    last_name: v.optional(v.string()),
    spouse_name: v.optional(v.string()),
    guest_type: v.union(
      v.literal("single"),
      v.literal("couple"),
      v.literal("family")
    ),
    max_party: v.number(),
    phone: v.optional(v.string()),
    email: v.optional(v.string()),
    deadline: v.string(),
    attendance: v.union(
      v.literal("invited"),
      v.literal("attending"),
      v.literal("declined"),
      v.literal("later")
    ),
    song_request: v.optional(v.string()),
    message: v.optional(v.string()),
    submitted_at: v.optional(v.string()),
  }),

  auth_tokens: defineTable({
    token: v.string(),
    created_at: v.number(),
  }),
});
