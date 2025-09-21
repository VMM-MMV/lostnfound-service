## **Budgeting Service**

Tracks FAF Cab finances, including donations, expenses, and user debts.

### **Responsibilities**

- Maintain a transparent log of all financial transactions.
- Manage a debt book for users who damage property.
- Provide financial reports.

### **Endpoints**

**Get Budget Logs**

- `GET /api/budget`

  - **Description:** Returns the current budget.

- `GET /api/budget/logs`

  - **Description:** Returns all budget logs.

- `GET /api/budget/logs?csv=true`

  - **Description:** Returns a CSV report of budget logs. This endpoint is only accessible to admins.

**Record a Transaction**

- `POST /api/budget`

  - **Description:** Adds a new financial transaction to the budget. This endpoint is only accessible to admins.
  - **Payload:**

    ```json
    {
      "entity": "user_id or partner name",
      "affiliation": "FAF/Partner",
      "amount": -100
    }
    ```

**Add to Debt Book**

- `POST /api/budget/debt`

  - **Description:** Adds a new debt entry for a user. This endpoint is only accessible to admins.
  - **Payload:**

    ```json
    {
      "responsable_id": "user-uuid-123",
      "creator_id": "admin-uuid-001",
      "amount": 100
    }
    ```

**Get User Debt**

- `GET /api/budget/debt`

  - **Description:** Retrieves the total debt
  - **Headers:** `Authorization: Bearer <jwt>` (Admin)

- `GET /api/budget/debt?responsable_id={id}`

  - **Description:** Retrieves the debt for a specific user. Accessible by admins or the user themselves.
  - **Headers:** `Authorization: Bearer <jwt>` (Admin or the user themselves)

**Get Debt Logs**

- `GET /api/budget/debt/logs`

  - **Description:** Returns all debt logs. Accessible only by admins.

- `GET /api/budget/debt/logs?responsable_id={id}`

  - **Description:** Returns debt logs for a specific user. Accessible by admins or the user themselves.