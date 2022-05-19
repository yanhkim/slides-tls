class: center, middle

# TLS(SSL) 101

---

class: center, middle

![](maxresdefault.jpg)

---

class: center, middle, handshake

![](handshake.png)

---

# 기본

- TLS 세션 생성 이후 통신은 대칭키 암호를 쓴다
  - AES, RC4, ...
  - 빠름
- 대칭키는 코드에 하드코딩되어 있는게 아니라 handshake 과정에서 만든다
  - 이때 공개키 암호를 사용 => RSA
  - 클라이언트가 pre master secret 을 서버의 공개키로 암호화해서 보냄
  - RSA 느림

---

class: center, middle, handshake

### 중요한 그림이라 두번

![](handshake.png)

---

class: center, middle

# _Demo_

---

class: center, middle

# Case study

---

# MITM vs TLS

--
- Client <--> Attacker <--> Server
  - 클라이언트와 서버가 서로 공개키 방식으로 암호화 통신을 하고 있다고 생각하지만, 공격자가 중간에 패킷을 가로채서 클라이언트와 서버가 공격자의 공개키로 통신하게 되는 해킹
  - 클라이언트와 서버가 보내는 메시지를 변조 가능

--
- TLS 에서는 공개키가 cert chain 으로 검증되어야 하기 때문에 방어 가능
  - 공격자의 공개키는 cert chain 안에 없으므로 경고 발생
  - cert chain 안에 있는 제 3자의 인증서를 준비한다고 하더라도, 그 제 3자의 비밀키를 모르므로 Handshake 실패

--
- 공격자가 cert chain 안으로 들어오거나, 서버의 개인키를 탈취하는 경우?
  - 노답

---

# Cipher downgrade vs TLS

--
- 공격자가 ServerHello 메시지에 개입하여 TLS 버전, 암호 선택을 downgrade 시도

--
- 서버 Finished 메시지에 그간 보낸 모든 Handshake 메시지가 마법의☆MD5 로 해시 되었으므로 클라이언트가 인지 가능

---

# DNS Spoofing vs TLS

--
- DNS 서버를 해킹해서 tokotalk.com 도메인을 공격자의 IP 주소로 설정

--
- 공격자가 tokotalk.com 의 인증서를 제공할 경우
  - Handshake 과정에서 공격자는 tokotalk.com 의 개인키가 없으므로 연결 실패

--
- 공격자가 자신의 인증서를 제공할 경우
  - 인증서의 cert chain 검증에서 실패할 것이므로 클라이언트의 브라우저에서 경고 발생

---

# References

- http://www.moserware.com/2009/06/first-few-milliseconds-of-https.html
- http://blog.jorisvisscher.com/2015/07/22/create-a-simple-https-server-with-openssl-s_server/
- https://www.madboa.com/geek/openssl/
- http://security.stackexchange.com/questions/94331/why-doesnt-dns-spoofing-work-against-https-sites
