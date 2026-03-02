### 1. Prevent File and Folder Browsing

- Restricts users from directly accessing files and folders in the application (e.g., browsing to the root path `http://localhost:port/`) without proper authentication.
- Implemented How:
  - Configured `web.config` to disable directory browsing, set `Login.aspx` as the default document, and restrict unauthorized paths.
  - Added a request validation check in `Application_BeginRequest` to ensure requests to `/` or `/Default.aspx` are redirected to `Login.aspx`, blocking direct unauthorized entry.
- Implemented: Yes

### 2. Session-Based Access Control / Prevent URL Browsing While Logout

- Ensures that only logged-in users can access protected pages.
- Direct URL access is blocked if the user is logged out. Any attempt to access a page without an active session redirects the user to the login page with an error message.
- Implemented How: Checked Session["UserId"] in BasePage using the CheckUserSession() method.
- Implemented: Yes

### 3. Session Timeout

- Automatically ends a user session after a period of inactivity to enhance security and free up server resources.
- Implemented How: Configured using ASP.NET session state settings (e.g., `web.config` session timeout value). When the session expires, users are redirected to the login page.
- Implemented: Yes

### 4. Menu-Based Navigation Enforcement

- Prevents users from accessing pages directly via URL typing or bookmarking.
- Only navigation through the application's menu is allowed.
- If the request does not come from the same host (i.e., not via the menu), the user is redirected to logout with an error message.
- That logging out from one tab also logs out the user from all other open tabs.
- Implemented How: Checked `Request.UrlReferrer` in `BasePage`.
- Implemented: Yes

### 5. Prevent Backwards/Forwards Navigation Across All Tabs

- Blocks browser back and forward actions to protect session data and ensures that logging out from one tab also logs out the user from all other open tabs.
- If the user navigates using the back or forward button, the user is redirected to logout with an error message.
- That logging out from one tab also logs out the user from all other open tabs.
- Implemented How: Uses a JavaScript technique that:
  - Listens to the `pageshow` event and checks the Navigation Timing API (`performance.getEntriesByType('navigation')`) to detect back/forward navigation.
  - Uses `localStorage` events to synchronize logout across all open tabs. When logout occurs in one tab, all other tabs automatically detect it and redirect to the Login page.
- Implemented: Yes

### 6. Prevent Browser Caching (No effect identified)

- Ensures that sensitive pages are never stored in the browser cache.
- This prevents users from seeing outdated content or bypassing session checks when navigating using the browser's back or forward buttons.
- Pages are always requested from the server, enabling proper session validation and logout enforcement.
- Users cannot view cached pages after logout or session expiration. Back and forward browser navigation always triggers a fresh server request.
- Implemented How: Achieved by setting HTTP cache headers in BasePage using Response.Cache methods.

```csharp
private void PreventBrowserCache()
{
    Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache); //prevents caching in browsers and proxies
    Response.Cache.SetNoStore(); //ensures pages are not stored
    Response.Cache.SetExpires(DateTime.UtcNow.AddSeconds(-1)); //marks pages as expired
    Response.Cache.SetRevalidation(System.Web.HttpCacheRevalidation.AllCaches); //forces cache revalidation with server
}
```

- Implemented : No
- How to check it :

1. Open your page in the browser.
2. Press Back after navigating to another page.
3. Without PreventBrowserCache(): the page might appear immediately from cache.
4. With PreventBrowserCache(): the browser requests the page from the server again (you can check in the Network tab of DevTools → you will see a new request).
5. Optionally, logout and press Back:
6. The page won’t render sensitive content; instead, your session check (CheckUserSession) will redirect to Login.

### 7. Maintain Page Refresh

- Description: Prevents duplicate form submissions that occur when a user refreshes the page (e.g., pressing F5 or Ctrl+R) after performing an Add or Update operation. Without handling, this could create multiple records or repeatedly update the same data.
- Implemented How: After each Add or Update action, the application redirects the user to a list page (Post/Redirect/Get pattern) or reloads the page with a GET request instead of resubmitting the previous POST data. This ensures the form submission is not repeated on refresh.
- Implemented: Yes
- How to Check:
  1. Perform an Add or Update operation.
  2. Try refreshing the page using `Reload this page` or `F5` or `Ctrl+R`.
  3. Confirm that no duplicate record is created and no unintended update occurs.

### 8. Multi-Tab Login

- Logging in from multiple tabs using the same user will automatically reset the session, allowing all tabs to work simultaneously.
- Logging in from multiple tabs using different users will reset the session for the new user, so all tabs will work correctly.
- Logging out from one tab will log out the user from all tabs automatically, as the session is cleared. After this, no tab will remain active.
- There is no need to prevent multiple tab logins for the same user session.
- Implementation Method: Uses session management
- Implemented: Yes

### 9. Multi Window Login

- Logging in from multiple windows using the same user will automatically reset the session, allowing all windows to work simultaneously.
- Logging in from multiple windows using different users will reset the session for the new user, so all windows will work correctly.
- Logging out from one window will log out the user from all windows automatically, as the session is cleared. After this, no window will remain active.
- There is no need to prevent multiple window logins for the same user session.
- Implementation Method: Uses session management
- Implemented: Yes

### 10. Single Device Login

- Only one device login per user is allowed.
- Implemented How: Uses device tracking and session logic.
- Implemented: No

### 11. Session Clear on Browser Close

- Intended to end the user session automatically when the browser or tab is closed.
- Implemented How: Could be achieved using JavaScript events like `beforeunload` or `onclose`.
- Implemented: No
- Note: This feature is not required because `Prevent URL Browsing While Logout` and `Menu-Based Navigation Enforcement` already ensure session security and controlled navigation.

### 12. Automatic Logout

- Intended to log out users automatically after 10 minutes of inactivity.
- Implemented How: Could be implemented using ASP.NET session timeout settings or a client-side inactivity timer.
- Implemented: No
- Note: This feature is not required because `Prevent URL Browsing While Logout` and `Menu-Based Navigation Enforcement` already ensure secure session handling and controlled navigation.

### 13. Password Expiry

- Forces users to change passwords after a defined time period.
- Implemented How: Uses configuration and session checks.
- Implemented: No

### 14. Password Complexity

- Enforces minimum length, alphanumeric, and special characters for passwords.
- Implemented How: Uses password rules and validation logic.
- Implemented: No

### 15. Default Password Change

- Requires changing default DSE password on first login.
- Implemented How: Uses login flow check.
- Implemented: No

### 16. Two-Factor Authentication (2FA) with OTP

- Sends a one-time password to the user’s email for authentication.
- Implemented How: Uses OTP service and email.
- Implemented: No

### 17. OTP Configuration

- Allows OTP settings to be configurable per user or category.
- Implemented How: Uses configuration settings.
- Implemented: No

### 18. Temporary Account Lock

- Locks user accounts temporarily after 10 incorrect login attempts.
- Implemented How: Uses login attempt counter.
- Implemented: No

### 19. Permanent Account Lock

- Locks accounts permanently after 3 additional failed login attempts following a temporary lock.
- Implemented How: Uses login attempt logic.
- Implemented: No

| SYS_PARAM                   | USER_INFO                   |
| --------------------------- | --------------------------- |
| IS_PROFILE_LOCK_ENABLE      | IS_PROFILE_LOCKED           |
| MAX_PASSWORD_WRONG_ATTEMPTS | MAX_PASSWORD_WRONG_ATTEMPTS |
| PROFILE_LOCK_TIME           | PROFILE_LOCK_UNTIL          |

```

                         +---------------------------+
                         |        User Login         |
                         +-------------+-------------+
                                       |
                         +----------------------------------+
                         |   Check IS_PROFILE_LOCK_ENABLE   |
                         |   && IS_PROFILE_LOCKED           |
                         +-------------+--------------------+
                                       |
             +-------------------------+-------------------------------+
             |                                                         |
             Yes                                                       No
             |                                                         |
   +------------------------------------------+                     +--------------------------------+
   |  Deny Login.. Show Account Permanently   |                     | Check PROFILE_LOCK_UNTIL       |
   +------------------------------------------+                     +---------------+----------------+
                                                                                    |
                                                                    +---------------+---------------+
                                                                    |                               |
                                                              Still Locked                      Lock Expired
                                                                    |                               |
                                                  +------------------------------+      +---------------------------+
                                                  | "Temporary Lock Active"      |      | Validate Username/Password|
                                                  | Deny Login                   |      +-------------+-------------+
                                                  +------------------------------+                    |
                                                                      +-------------------------------+-------------------------------+
                                                                      |                                                               |
                                                                    Valid                                                           Invalid
                                                                      |                                                               |
                                                          +------------------------+                                  +------------------------------------+
                                                          |   Login Successful     |                                  | Increment PASSWORD_WRONG_ATTEMPTS  |
                                                          +-----------+------------+                                  +----------------+-------------------+
                                                                      |                                                                |
                                                          +----------------------------------------+                +--------------------------------------------+
                                                          | Reset MAX_PASSWORD_WRONG_ATTEMPTS = 0  |                | Compare with MAX_PASSWORD_WRONG_ATTEMPTS   |
                                                          +----------------------------------------+                +----------------+---------------------------+
                                                                                                                                       |
                                                                                                     +---------------------------------+----------------------------+
                                                                                                     |                                                              |
                                                                                                   Exceeded                                                     Not Exceeded
                                                                                                     |                                                              |
                                                                            +--------------------------------------------------+                  +---------------------------+
                                                                            |  Check PROFILE_LOCK_UNTIL Already Existed?       |                  | Allow Another Attempt     |
                                                                            +------------------------+-------------------------+                  +---------------------------+
                                                                                                    |
                                                                              +---------------------+---------------------------------+
                                                                              |                                                       |
                                                                        Yes — Temporary Lock was Active                         No — First Time Exceed
                                                                              |                                                      |
                                                    +------------------------------------------------+            +-----------------------------------------------+
                                                    |   PERMANENT LOCK                               |            |  TEMPORARY LOCK                                |
                                                    |   Set IS_PROFILE_LOCKED = 'YES'                |            |  Set IS_PROFILE_LOCKED = 'NO'                  |
                                                    |   Clear PROFILE_LOCK_UNTIL (optional)          |            |  Set PROFILE_LOCK_UNTIL = SYSDATE + LOCK_TIME  |
                                                    +------------------------------------------------+            +-----------------------------------------------+
                                                                              |                                                       |
                                                              +-----------------------------------+                     +-----------------------------------+
                                                              | Show "Account Permanently Locked" |                     | Show "Account Temporarily Locked" |
                                                              +-----------------------------------+                     +-----------------------------------+

```

### 20. JavaScript Check on Login

- Disables login if JavaScript is turned off in the browser.
- Implemented How: Uses client-side JavaScript validation.
- Implemented: No

### 21. JavaScript Mid-Session Check

- Clears session if JavaScript is disabled mid-session.
- Implemented How: Uses JavaScript heartbeat and session checks.
- Implemented: No

### 22. Browser Version Restriction

- Blocks outdated browsers.
- Implemented How: Uses JavaScript and server-side checks.
- Implemented: No

### 23. Browser Type Restriction

- Only Chrome and Firefox browsers are allowed.
- Implemented How: Uses JavaScript and server-side checks.
- Implemented: No

### 24. Disable Right-Click

- Prevents context menu and unauthorized link copying.
- Implemented How: Uses JavaScript.
- Implemented: No

### 25. Copy/Paste Restriction

- Disables copy/paste except for allowed fields.
- Implemented How: Uses JavaScript event blocking.
- Implemented: No

### 26. Illegal Character Blocking

- Prevents injection attacks through input validation.
- Implemented How: Uses input validation and regular expressions.
- Implemented: No

### 27. Function Keys Disabled

- Disables certain function keys to prevent shortcuts or unauthorized actions.
- Implemented How: Uses JavaScript keydown blocking.
- Implemented: No

### 28. Developer Tools Restriction

- Attempts to prevent access to browser developer tools.
- Implemented How: Uses JavaScript console blocking and event monitoring.
- Implemented: No
