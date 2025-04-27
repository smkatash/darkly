# Hidden Field Manipulation

**Hidden Field Manipulation (HFM)** is a web application attack where an attacker alters the values of hidden fields in HTML forms. These hidden fields are intended to store data that the user should not modify — such as session identifiers, user roles, prices, or other sensitive data — but are still visible and editable in the client-side code.

Since hidden fields are part of the HTML document sent to the browser, attackers can inspect and modify them using browser developer tools or intercepting proxies like Burp Suite.

### 🔍 Common Attack Scenarios:

- **Authentication Bypass**  
  If a hidden field stores a user ID or session ID, an attacker can alter the value to impersonate another user or escalate privileges.  
  _Example: Changing a hidden field from `user_id=123` to `user_id=1` to impersonate an admin._

- **Payment Manipulation**  
  In e-commerce apps, hidden fields may store item prices. An attacker could reduce the value to pay less.  
  _Example: Modifying a hidden field from `price=100` to `price=1`._

- **Data Tampering**  
  Hidden fields that reference database records can be altered to modify or delete unintended data.  
  _Example: Changing `record_id=42` to `record_id=1` in a delete request._

- **Cross-Site Request Forgery (CSRF)**  
  Malicious hidden fields can be injected into forms submitted unknowingly by users, triggering unauthorized actions.  
  _Example: A hidden field pointing to a malicious URL that auto-submits via CSRF._

## Mitigations

To protect against Hidden Field Manipulation:

- **Never trust client-side data** — including hidden fields. Always validate and enforce security checks on the server side.
- **Use server-side session tracking** instead of storing sensitive session information in the client.
- **Digitally sign or hash critical hidden field values** (e.g., with HMAC) to detect tampering.
- **Avoid storing sensitive data in hidden fields**, especially roles, prices, or access control references.
- **Implement proper access controls** on the server to prevent unauthorized actions, regardless of field input.
- **Use HTTPS** to protect data in transit and reduce the risk of interception or MITM manipulation.
- **Log suspicious activity**, such as invalid or unexpected form values.

## References
- [Hidden Field Manipulation](https://cqr.company/web-vulnerabilities/hidden-field-manipulation/)

## Exercise
1. Inspect form
```
<form action="#" method="POST"> <input type="hidden" name="mail" value="webmaster@borntosec.com"
								maxlength="15"> <input type="submit" name="Submit" value="Submit"> </form>
```

2. Modify email through setting type to text and submit the form.