# Referer Spoofing

**Referer Spoofing** is an attack where the attacker forges or manipulates the `Referer` header in an HTTP request to bypass security controls or impersonate trusted sources. Some web applications use the `Referer` header as a method of validating the origin of a request — for example, allowing certain actions only if the request comes from a specific internal page.

Because the `Referer` header is entirely controlled by the client, relying on it for access control or authentication is insecure and can lead to unauthorized access.

### 🛠️ Example Attack Scenario

A web application restricts access to `/admin/delete-user` unless the request comes from `/admin/dashboard`. It checks the `Referer` header like this:

```http
Referer: https://example.com/admin/dashboard
```

An attacker can craft a request with a fake Referer:
```
POST /admin/delete-user HTTP/1.1
Host: example.com
Referer: https://example.com/admin/dashboard
```

If the server relies on this header for authorization, the attacker may gain unauthorized access.

___

This vulnerability falls under the following **OWASP Top 10** categories:

- **A01:2021 – Broken Access Control**  
  *Primary category – access control enforced via spoofable headers.*

- **A05:2021 – Security Misconfiguration**  
  *Server trusts unvalidated headers for sensitive decisions.*

- **A07:2021 – Identification and Authentication Failures**  
  *If the header is misused as an authentication mechanism.*

## Mitigations

To prevent **Referer Spoofing**, follow these best practices:

- **Never rely on the `Referer` header** for access control or authentication.
- **Use strong, server-side authorization mechanisms** that validate user identity and permissions.
- **Implement proper CSRF protections**, such as synchronizer tokens or same-site cookies, instead of checking `Referer`.
- **Use secure session management** and enforce privilege checks for all sensitive actions.
- **Log and monitor unusual `Referer` headers** or suspicious attempts to access protected routes.


## References
- [Broken Access Control](https://owasp.org/www-community/Broken_Access_Control)
- [Security Misconfiguration](https://owasp.org/www-project-mobile-top-10/2023-risks/m8-security-misconfiguration)
- [Identification and Authentication Failures](https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/)

## Exercise
By scraping and inspecting page with long token/hash, the hint below was found.
```
You must come from : "https://www.nsa.gov/"
Let's use this browser : "ft_bornToSec". It will help you a lot.
```

To spoof and send a request to the page, referer and user-agent had to be modified
```
curl -s --referer "https://www.nsa.gov/" --user-agent "ft_bornToSec" "$target_url"
```