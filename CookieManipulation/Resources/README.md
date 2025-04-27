# Session Hijacking Attack

Session hijacking involves exploiting the web session control mechanism, which relies on session tokens to identify users. Since HTTP communication uses multiple TCP connections, web servers issue a **session token** to the client upon successful authentication. This token allows the server to associate future requests with the same user.

Session tokens may be transmitted via:

- URL parameters  
- HTTP headers (typically as cookies)  
- Body of HTTP requests  

If an attacker can steal or predict a valid session token, they can impersonate the user and gain unauthorized access.

### Common Methods of Session Hijacking:

- **Predictable session tokens**  
- **Session sniffing** (e.g., capturing traffic on an unencrypted network)  
- **Client-side attacks** such as XSS, malicious JavaScript, or trojans  
- **Man-in-the-middle (MitM) attacks**  
- **Man-in-the-browser attacks**

## Mitigations

To prevent session hijacking, consider the following practices:

- **Use HTTPS** for all communication to protect session tokens from interception.
- **Regenerate session tokens** after login and during privilege changes.
- **Set the `HttpOnly` and `Secure` flags** on session cookies to prevent client-side access.
- **Implement session expiration** after a period of inactivity.
- **Enable re-authentication** for sensitive actions.
- **Restrict sessions by IP address or user-agent** (when feasible).
- **Use strong, unpredictable session identifiers.**
- **Monitor and alert** on suspicious session activity.

---

# Web Parameter Tampering

Web Parameter Tampering is the manipulation of parameters exchanged between the client and server to alter application behavior or access unauthorized data. Parameters can include:

- Cookies  
- Hidden form fields  
- URL query strings  
- HTTP headers  

This attack is commonly used to modify data such as user credentials, privileges, pricing, or product quantities.

### Types of Parameter Tampering:

- **Cookie Manipulation**  
- **Form Field Manipulation**  
- **URL Manipulation**  
- **HTTP Header Manipulation**

### Tools Commonly Used:

- WebScarab  
- Paros Proxy  
- Burp Suite  

Parameter tampering often succeeds due to weak server-side validation and flawed application logic, and may lead to more severe attacks like:

- Cross-Site Scripting (XSS)  
- SQL Injection  
- File Inclusion  
- Path Disclosure

## Mitigations

To mitigate parameter tampering:

- **Perform server-side validation** of all client input, regardless of client-side restrictions.
- **Use integrity checks** like HMACs or digital signatures for sensitive data in hidden fields or cookies.
- **Avoid relying on client-side controls** (JavaScript or hidden fields) for critical logic decisions.
- **Limit trust in user input** by validating authorization and access on every request.
- **Encrypt or obfuscate critical parameters** if they must be sent to the client.
- **Implement logging and alerting** to detect abnormal parameter usage.


## References

- [Web Parameter Tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)
- [Session hijacking attack](https://owasp.org/www-community/attacks/Session_hijacking_attack)
- [Cookie Manipulation](https://medium.com/@techmindxperts/what-is-parameter-tempering-ecb0d1a6a04)

## Exercise

In this exercise, by inspecting the responses of the server the session cookie is found to be vulnerable, since if the current user is not admin, we can try to predict the cookie to upgrade permission.
Following is the request headers:
```
GET / HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-GB,en;q=0.9
Connection: keep-alive
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Host: 192.168.0.102
Referer: http://192.168.0.102/?page=signin&username=root&password=shadow&Login=Login
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1.1 Safari/605.1.15 Ddg/18.1.1
```

By using Hash identifier: https://hashes.com/en/decrypt/hash, the possible hash md5 has been identified.
MD5 hash decrypted 68934a3e9455fa72420237eb05902327 to false.
So we will try to set I_am_admin= to true, the MD5 hash encrypted true to b326b5062b2f0e69046810717534cb09

