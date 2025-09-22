
## **Lost & Found Service**

A digital bulletin board for items lost or found in the university.

### **Docker**

To set up the environment, create a `.env` file in the **same directory** as your `docker-compose.yml` with the following contents:

```env
POSTGRES_USER=<POSTGRES_USER>
POSTGRES_PASSWORD=<POSTGRES_PASSWORD>
POSTGRES_DB=<POSTGRES_DB>
POSTGRES_HOST=<POSTGRES_HOST>
JWT_SECRET=<JWT_SECRET>

PHOENIX_HOST=<PHOENIX_HOST>
SECRET_KEY_BASE=<SECRET_KEY_BASE>
PHX_SERVER=true
```

This file will provide all the necessary environment variables for the Docker containers.

And this is a example for `docker-compose`

```yaml
budget:
  build: .
  restart: always
  ports:
    - "4000:4000"
  environment:
    DATABASE_URL: ecto://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}/${POSTGRES_DB}
    PHOENIX_HOST: ${PHOENIX_HOST}
    SECRET_KEY_BASE: ${SECRET_KEY_BASE}
    JWT_SECRET: ${JWT_SECRET}
    PHX_SERVER: true
  depends_on:
    - db
```

---

### **Docker Hub**

The service is available on Docker Hub:
[https://hub.docker.com/r/vmmmmv/lostnfound](https://hub.docker.com/r/vmmmmv/lostnfound)

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
***General Message Format (all events):***
    
   ```json
   {
     "topic": "lostnfound:<post_id>",
     "event": "<event_name>",
     "payload": { },
     "ref": "1"
   }
   ```
    
   -   `topic` → always `lostnfound:<post_id>`
       
   -   `event` → the action (`phx_join`, `post_message`, `list_messages`, …)
       
   -   `payload` → data sent with the event
       
   -   `ref` → client reference number (starts at `"1"`, increments per message)
   
**Join a Post Channel**

-   **Event:** `phx_join`
    
-   **Payload:**
    
    ```json
    {
      "topic": "lostnfound:1",
      "event": "phx_join",
      "payload": {},
      "ref": "1"
    }
    ```
    

**Post a Message**

-   **Event:** `post_message`
    
-   **Payload:**
    
    ```json
    {
      "topic": "lostnfound:1",
      "event": "post_message",
      "payload": {"content": "Test message"},
      "ref": "2"
    }
    ```
    

**List Messages**

-   **Event:** `list_messages`
    
-   **Payload:**
    
    ```json
    {
      "topic": "lostnfound:1",
      "event": "list_messages",
      "payload": {},
      "ref": "3"
    }
    ```
    

----------

### **Server → Client Broadcasts (WebSocket)**

**Message Posted**

-   **Event:** `post_message`
    
-   **Broadcast Payload:**
    
    ```json
    {
      "type": "post_message",
      "post_id": "1",
      "message_id": "msg-uuid-123",
      "user_id": "user-uuid-456",
      "content": "Test message",
      "ts": "2025-09-22T00:00:00Z"
    }
    ```
    

**Message List Response**

-   **Reply to `list_messages`:**
    
    ```json
    {
      "messages": [
        {
          "message_id": "msg-uuid-123",
          "post_id": "1",
          "user_id": "user-uuid-456",
          "content": "First message",
          "ts": "2025-09-22T00:00:00Z"
        },
        {
          "message_id": "msg-uuid-124",
          "post_id": "1",
          "user_id": "user-uuid-789",
          "content": "Second message",
          "ts": "2025-09-22T00:05:00Z"
        }
      ]
    }
    ```