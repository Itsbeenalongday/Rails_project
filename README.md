cd s# Note

인강들으면서 리마인드

## reference

+ [도라도라 블로그](https://kbs4674.tistory.com/)

+ [인썸니아 인강](https://insomenia.com/courses)

+ [ruby cheat-sheet](https://github.com/Itsbeenalongday/Ruby-study)

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

<div align="center">

![](./img/ORM.PNG)

</div>

## 구현하기

### 1. 컨트롤러 생성
```bash

$ rails g controller <controller name>

```
컨트롤러를 생성하게 되면, 자동적으로 대응되는 View파일이 생성된다.

### 2. app 폴더 내에 MVC가 존재한다.

```
app/
|
|-- controllers/
|
|-- models/
|
|-- views/
```

### 3. action에서는 데이터를 처리하고 view에서는 결과를 보여준다

**rails에서는 view파일이름과 controller파일이름을 같게 만들어줘야한다.**

### 4. erb는 ruby코드를 삽입할 수 있는 html의 확장판이다. (erb == embedded ruby)

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

### 5. action하고 view를 만들면 항상 경로를 지정해야한다.

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

### 6. 정보전송 

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

params 내용은 
```ruby
{"args"=>"~~~"...,"controller"=>"homw", "action"=>"attack"}
```
이러한데, 뜯어보면home controller의 attack액션에서 args들을 할 수 있다.   

**erb파일에서 ruby코드 사용법**

```
=는 화면에 보여주고 싶을 때 optional하게 사용
<%(=) codes... %>
```

+ 작업의 흐름

![](./img/flow.PNG)

### 7. controller를 만들 때 액션과 라우트를 자동으로 설정하기

```bash

$ rails g controller <controller name> <actions...>
```

### 8. get과 post의 차이

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

```ruby
{"authenticity_token"=>"9oDN41lX9b72eU6UAKcmifcWFcs1Bmh2wXuZqJ6aFG+/bY9FBSfLLXxQ8LBlq/R1m2Dzu4a/OJLAiT6netS8og==", "post_title"=>"3213", "post_content"=>"123213213", "controller"=>"home", "action"=>"create"}
```

ruby의 form_for를 쓰면 보안 토큰을 안전하게 처리

### 9. 모델 생성하기

```bash
$ rails g model <model_name>
```

제목, 내용을 저장할 table=> model
            +
입력한 정보를 테이블에 넣어주는 기능=> create 액션


/app/model/모델.rb

/db/migrate/테이블.rb => 테이블의 모양을 결정

테이블의 모양을 확정
```bash
$ rails db:migrate
```

테이블 삭제
```bash
$ rails db:drop
```

이제 테이블의 내용을 params를 이용하여 쌓아나간다

**어떻게 controller의 instance variable을 view에서 사용할 수 있는것인가?**

[rails opensource](https://github.com/rails/rails/blob/0c5552a3dd28e35cce64462765cc41c5355db0f1/actionpack/lib/abstract_controller/rendering.rb#L84-L86)

```ruby
view가 rendering될 때, 인스턴스 변스와 그 값이 controller에서 선택되어,
view의 initializer로 전달되고, view 인스턴스가 만들어진다.

아래와 같은 ruby method들이 사용된다

*instance_variables - gets names of instance variables 
*instance_variable_get(variable_name) - gets value of an instance variable
*instance_variable_set(variable_name, variable_value) - sets value of an instance variable

과정을 보자

1. controller에서 instance variable을 뽑아낸다.

def view_assigns
  hash = {}
  variables  = instance_variables
  variables -= protected_instance_variables
  variables -= DEFAULT_PROTECTED_INSTANCE_VARIABLES
  variables.each { |name| hash[name[1..-1]] = instance_variable_get(name) }
  hash
end

2. view로 instance variable을 전달한다
def view_context
  view_context_class.new(view_renderer, view_assigns, self)
end

3. view를 setting한다
def assign(new_assigns) # :nodoc:
  @_assigns = new_assigns.each { |key, value| instance_variable_set("@#{key}", value) }
end
```

### 10. db에 들어간 데이터 조회

```bash
$ rails c

irb(main):001:0> Post.all 
```
rails c 명령은 rails interperter를 실행시키는 명령이다      
여기서 Post.all을 하게되면 Post 모델의 모든 데이터가 조회된다.   

index페이지에서 이것을 확인해보자
```ruby html
<% Post.all.each do |instance| %>
    제목: <%=instance.title%><br/>
    내용: <%=instance.content%><br/>
    <% for i in 0...instance.content.length %>
    <%= '_' %>
    <% end %>
    <br/>
<%end%>
```

### 11. 삭제

늘 그렇듯 어떤 기능을 만들려고 하면 해당 프로세스를 따른다

```
< controller에서 액션을 만든다 >
          |
          v
< 액션에 맞는 라우팅을 지정한다 >
          |
          v
  < 액션에서 수행할 결과>
          |
          | -------------> 안 보여줘도 된다.
          |
          v 보여준다
< view로 가서 html.erb를 만들어서 꾸민다 >
```

delete도 마찬가지임

+ 모든 instance 삭제
```bash
irb(main):001:0> Post.destroy_all
```
+ 특정 instance 삭제 - id이용

```ruby
<% Post.all.each do |instance| %>
    제목: <%=instance.title%><br/>
    내용: <%=instance.content%><br/>
    <a href="/home/destroy/<%=instance.id%>">[삭제]</a><br/>
    <% for i in 0...instance.content.length %>
    <%= '_' %>
    <% end %>
    <br/>
<%end%>
```
url에 id를 추가하였다 -> route설정도 다시 해줘야 한다.
params(액션으로 넘기는 모든 정보)로 id를 알 수 있다.

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/index'
  # get 'home/index' => home#index
  # home/index가 get방식으로 요청되면 home controller의 index액션을 실행
  # 이게 없으면 redirect_to '/home/index'에서 에러가 난다
  get 'home/new'
  post 'home/create'

  # url과 action이 같다면 단축이가능한데
  # 이제 destroy와 destroy/:post_id로 url이 구분되므로 위와같이 단축할 수 없다. 
  # 아래와 같이 url이 요청되면 home controller의 destroy액션으로 이동해라를 명시해야함
  get 'home/destroy/:post_id' => 'home#destroy'
  # /post_id, 문자그대로 post_id url이 됨
  # /:post_id, post_id를 변수로 만들어 id를 저장할 수 있다.
end

```

### 12. 수정

수정하면서 id는 두 번 쓰이게 된다   
1. 수정하는 양식에 이전에 썼던 특정 내용을 불러올 때   
2. 이전 글을 수정한 뒤 새로운 내용으로 업데이트 할 때   

```ruby
 def edit
        @post = Post.find(params[:post_id]) # 이전 내용을 불러온다
    end

    def update
        # 인스턴스 변수를 사용하는 경우는 view파일에서 사용해야 할 때 사용
        post = Post.find(params[:post_id])
        post.title = params[:post_title]
        post.content = params[:post_content]
        post.save

        redirect_to "/home/index"
    end
```

edit은 글을 수정하는 공간으로 이동시키는 액션

update는 수정된 글을 반영하는 액션

으로 볼 수 있다.

다음은 routes.rb파일의 일부이다.

```ruby
# 수정하는 공간으로 라우팅
  get 'home/edit/:post_id' => 'home#edit'
  # 수정을 반영하기 위한 라우팅
  post 'home/update/:post_id' => 'home#update'
```
`수정하고싶은 것`만 수정하면 되기에 글 전체를 지칭하는 것이 아닌,   
특정글을 선택하여 수정해야한다.   
때문에 id가 필요하게 되고, 해당 글을 수정하기 위해 url에 id를 넘겨준다.   

```ruby
# edit.html.erb

<form action="/home/update/<%=@post.id%>" method="post">
    <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
    제목: <input type="text" name="post_title" value=<%=@post.title%>><br/>
    내용: <textarea name="post_content"><%=@post.content%></textarea><br/>
    <input type="submit" value="수정">
</form>
```
여기서는 기존 내용을 불러와야 하기 때문에 value에 title과 content가 들어간 것을 볼 수 있다   

action으로 지정된 것은 update인 것을 확인 할 수 있는데 제출을 하게 되면, update액션으로 이동하게 된다.

### 13. scaffold

+ view_helper
view를 다루기 쉽게 만든다.

1. a태그를 쉽게 대체해 보자

```ruby html
<%=link_to '텍스트', url %>

<a href="url"> 텍스트 </a>
```

**주의점**
```ruby
<%= link_to '삭제', "posts/destroy/#{post.id}">
```
루비 문법을 써야하는 상태에서   
문자열 안에 문자가 아닌 변수를 넣으려면   
`#{}`로 감싸줘야 한다   

**url을 간소화 해보기**
```ruby
 # 수정하는 공간으로 라우팅
  get 'home/edit/:post_id' => 'home#edit', as: 'home_destroy'
  # 수정을 반영하기 위한 라우팅
  post 'home/update/:post_id' => 'home#update', as: 'home_update'
```

저렇게 as로 이름을 바꾸고

```ruby
<%=link_to 'content', home_destroy_path(post_id: post.id) %>
```
_path를 붙이고 keyword argument(안쓰고 post.id만 넘겨도 됨)를 지정해서 넘기게 되면   
url을 대체할 수 있다   

2. Restful

+ scaffold
구조, 뼈대라는 뜻으로   
rails에서 scaffold는 migration/ model/ routes/ controller/ view를 한 번에 처리할 수 있는 것을 말한다. 

```bash
$ rails g scaffold posts title:string content:text
```
로 하게 되면,   
모델이름은 Post가 되고, 컨트롤러이름은 posts가 된다.

controller이름은 model의 복수형으로 만드는 것이 관례  

하고 난 후에 migration file을 확인하고, 테이블을 확정지어줘야 한다.

```bash
$ rails db:migrate
```

Restful은 무엇(resource)을 어떻게(HTTP method) 할 지 표현

+ resource는 crud할 수 있는 정보 ex) 하나의 게시물, 유저, 댓글 etc...

+ HTTP method 추출(GET)/ 생성(POST)/ 변경(PUT/PATCH)/ 제거(DELETE)

어떤 동작을 할 지 예측할 수 있다.

<div align="center">

![](./img/restful.PNG)

</div>

왜 HTTP method를 사용하는가?

```
같은 url을 사용하고, http method로 동작을 달리 지정해주면,
url을 재사용할 수 있고, 서버의 처리측면에서도 효율적이다

/post/:id --|-- get
            |-- put
            |-- delete
```

다음은 index.html.erb의 일부이다

```ruby
<% @posts.each do |post| %>
      <tr>
        <td><%= post.title %></td>
        <td><%= post.content %></td>
        <td><%= link_to 'Show', post %></td>
        <td><%= link_to 'Edit', edit_post_path(post) %></td>
        <td><%= link_to 'Destroy', post, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
```

link_to의 url부분에 post가 들어가 있는 것을 볼 수 있다.   
여기서 post는 게시글 하나를 지칭하는 것이기 때문에 url 부분에 post를 쓰게되면   
알아서 자동적으로 url을 생성해주고, 우리가 할 일은 method만 지정해주면 되는 것이다.   
post는 post_path(id: post.id) 또는 post_path(post)와 동일한 것이다.   
그리고 method를 따로 지정하지 않으면 default는 get이다.   

