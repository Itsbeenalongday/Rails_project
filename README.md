# Note

인강들으면서 리마인드

## ORM

Object-Relation Mapper

instance가 많아지면 기억을 못하기에 database로 관리한다

DB 관리 언어

SQL

SQL로 관리하는 DB - 관게형 데이터베이스

```sql
select * from users where name = "dodo"
```

Rails에서 사용하는 ORM Framework를 Active Record라고 부른다.
이것을 사용하여 SQL을 사용하지 않고 ORM으로 DB 접근한다.

![](./img/ORM.PNG)

## Environment

![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/1200px-Ruby_On_Rails_Logo.svg.png)

## reference

+ [도라도라 블로그](https://kbs4674.tistory.com/)

+ [인썸니아 인강](https://insomenia.com/courses)

+ [ruby cheat-sheet](https://github.com/Itsbeenalongday/Ruby-study)

## VC 구현하기

1. 컨트롤러 생성
```bash

$ rails g controller <controller name>

```
컨트롤러를 생성하게 되면, 자동적으로 대응되는 View파일이 생성된다.

2. app 폴더 내에 MVC가 존재한다.

app/
|
|-- controllers/
|
|-- models/
|
|-- views/

3. action에서는 데이터를 처리하고 view에서는 결과를 보여준다

**rails에서는 view파일이름과 controller파일이름을 같게 만들어줘야한다.**

4. erb는 ruby코드를 삽입할 수 있는 html의 확장판이다. (erb == embedded ruby)

views/layouts/ 내에 applications.html.erb가 존재하는데, 이 것은 쉽게 생각하면 만들어지는 view파일의 슈퍼조상이라고 생각하면 편하다

applications.html.erb
```ruby
<!DOCTYPE html>
<html>
  <head>
    <title>BlogProject</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```
위 yield태그는 사용자가 만드는 erb파일을 가리키게된다 예를 들어,
만약 사용자가 index.html.erb를 생성하게 되면 위 구조를 따르되, yield태그를 사용하여
사용자가 작성한 코드를 작성하게 되면 그 내용이 yield태그를 대체하게 되어 하나의 html이 만들어 지는 것이다
java에서 abstract개념과 비슷하다. 구현은 뒤로미루고 상속받는 erb에서 구현되게 만들어 놓는 그런 느낌이다.

5. action하고 view를 만들면 항상 경로를 지정해야한다.

/config/routes.rb에서 경로지정

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#<erb file name>" # localhost:3000접속시 보여주는 페이지 지정 - root
end
```

+ routing
>어떤 url이 들어오면 이런 방식(url 요청방식)으로 저런 동작(컨트롤러 액션)을 해라

형식
```
<url요청방식> <사용자가 요청하는 url>, to: <요청된 url을 처리할 컨트롤러#액션>
```

```ruby
home컨트롤러의 attack액션
get '/attack', to: 'home#attack'
home컨트롤러의 defense액션
get '/defense' to: 'home#defense'
```

6. 정보전송 

form태그로 정보를 전송했다고 하자
그러면 보낸 정보들이 해당 url을 처리하는 액션(메소드)에서 처리를 같이해라
이 정보들은 어디담겨있느냐?
-> params

```ruby
<%= params %>
```

일련의 과정을 정리해보면 이렇다
1. index페이지에서 form태그를 사용하여 /attack url로 정보를 params에 담아서 전송하게 된다
2. 해당 url을 처리하는 액션에서 이 정보를 받아 처리할 수 있다.
3. /attack url에서 `<%=params%>`를 통해서 전달된 정보를 확인할 수 있다.

params 내용은 {"args"=>"~~~"...,"controller"=>"homw", "action"=>"attack"} 이러한데, 뜯어보면
home controller의 attack액션에서 args들을 할 수 있다.

**erb파일에서 ruby코드 사용법**

```
=는 화면에 보여주고 싶을 때 optional하게 사용
<%(=) codes... %>
```

+ 작업의 흐름

![](./img/flow.PNG)

7. controller를 만들 때 액션과 라우트를 자동으로 설정하기

```bash

$ rails g controller <controller name> <actions...>
```

8. get과 post의 차이

+ get: 입력한 정보를 url에 노출(노출이 되어도 상관없는 정보)

```html
<form action="/home/create" method="get">
    제목: <input type="text" name="post_title"><br/>
    내용: <textarea name="post_content"></textarea><br/>
    <input type="submit" value="작성">
</form>
```
작성시 이동된 url

http://localhost:3000/home/create?post_title=d&post_content=dd

+ post: 입력한 정보를 숨겨서 보냄(노출이 되면 안되는 정보)

```html
<form action="/home/create" method="post">
    제목: <input type="text" name="post_title"><br/>
    내용: <textarea name="post_content"></textarea><br/>
    <input type="submit" value="작성">
</form>
```

```ruby
post 'home/create'
```

보안토큰 에러가 난다. => CSRF 해킹공격때문에 막아놓았다

그래서 form태그에 
```ruby html
<%= hidden_field_tag :authenticity_token, form_authenticity_token %>
```
이 코드를 붙여야한다.

params를 보면 아래와 같이 보안토큰이 붙은 것을 볼 수 있다.

{"authenticity_token"=>"9oDN41lX9b72eU6UAKcmifcWFcs1Bmh2wXuZqJ6aFG+/bY9FBSfLLXxQ8LBlq/R1m2Dzu4a/OJLAiT6netS8og==", "post_title"=>"3213", "post_content"=>"123213213", "controller"=>"home", "action"=>"create"}

ruby의 form_for를 쓰면 보안 토큰을 안전하게 처리