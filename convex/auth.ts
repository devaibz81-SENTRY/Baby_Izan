const ADMIN_PASSWORD = "IzanShower2026!";

export function verifyPassword(password: string): boolean {
  return password === ADMIN_PASSWORD;
}

export async function createToken(db: any): Promise<string> {
  const token =
    Math.random().toString(36).substring(2) +
    Math.random().toString(36).substring(2);
  await db.insert("auth_tokens", {
    token,
    created_at: Date.now(),
  });
  return token;
}

export async function validateToken(db: any, token: string): Promise<boolean> {
  const found = await db
    .query("auth_tokens")
    .filter((q: any) => q.eq(q.field("token"), token))
    .first();
  if (!found) return false;
  if (Date.now() - found.created_at > 24 * 60 * 60 * 1000) {
    await db.delete(found._id);
    return false;
  }
  return true;
}

export async function deleteToken(db: any, token: string): Promise<void> {
  const found = await db
    .query("auth_tokens")
    .filter((q: any) => q.eq(q.field("token"), token))
    .first();
  if (found) {
    await db.delete(found._id);
  }
}
