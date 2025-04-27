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

On ?page=feedback, after inspecting the index file, the function checkForm() appears to be missing.

1. When the form is submited, we inspect the DevTools and get: 
```
Uncaught ReferenceError: checkForm is not defined
    onclick ?page=feedback:1
192.168.0.102:1:1
    onclick /?page=feedback:1
```

2. We want to skip the validation, so we try to override the on submit definition of 
<form method="post" name="guestform" onsubmit="return validate_form(this)"> 

Paste custom function in to Console, to override the behaviour
```
function checkForm() {
	document.querySelector('[name=guestform]').setAttribute('onsubmit', 'return true;');
}
```

3. Paste the "malicious" script into input field to inject information (validation shall be skipped).
```
<script>alert("XSS")</script>
```