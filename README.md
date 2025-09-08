## **Lost & Found Service**

A digital bulletin board for items lost or found in the university.

### **Responsibilities**

- Allow users to create, update, and comment on posts.
- Mark posts as "resolved."

### **Endpoints**

**Create a Post**

- `POST /api/lostnfound`
  - **Description:** Creates a new post for a lost or found item.
  - **Headers:** `Authorization: Bearer <jwt>`
  - **Payload:**
    ```json
    {
      "user_id": "user-uuid-123",
      "status": "unresolved",
      "description": "I lost my will to live in faf cab. Would very grateful if somebody finds it"
    }
    ```

**Update Post Status**

- `PATCH /api/lostnfound/{post_id}`
  - **Description:** Updates the status of a post. Only the creator or an admin can update it.
  - **Headers:** `Authorization: Bearer <jwt>`
  - **Payload:**
    ```json
    {
      "status": "resolved"
    }
    ```

**WebSocket Connection**

- `wss://api.faf/ws/lostnfound/{post_id}?token=<JWT>`
  - **Description:** Establishes a WebSocket connection for real-time updates and comments on a specific post.

**Client → Server Events (WebSocket)**

- `subscribe_post`: `{"type":"subscribe_post", "post_id":"p123"}`
- `post_message`: `{"type":"post_message", "post_id":"p123", "content":"Damn bro thats crazy", "client_ts":"..."}`

**Server → Client Events (WebSocket)**

- `post_message`: `{"type":"post_message", "post_id":"p123", "message_id":"m1", "user_id":"uX", "content":"...", "ts":"..."}`
- `post_updated`: `{"type":"post_updated", "post_id":"p123", "status":"resolved"}`
- `moderation_warning`: `{"type":"moderation_warning", "user_id":"u789", "reason":"banned_word", "count":1}`
- `moderation_ban`: `{"type":"moderation_ban", "user_id":"u789", "reason":"exceeded_infractions"}`
