<!DOCTYPE html>
<html>
<head>
    <title>SUBSURFACE</title>
</head>

<body>

  <div class="content">
    <br>
            
      <header class="intro">
      <div class="intro-body">
        <div class="container">
          <div class="row">
            <div class="col-md-8 col-md-offset-2">
            <br><br>
              <h1 class="brand-heading">SUBSURFACE</h1>
              <p class="intro-text">ELECTRONIC MUSIC EVENTS <span style="color: red"> // </span> DUBLIN</p>

              <sec:ifNotLoggedIn>
                <g:link controller = "login">
                  <span>LOGIN</span>
                </g:link>
              </sec:ifNotLoggedIn>

              <sec:ifLoggedIn>
                <g:link controller = "logout">
                  <span>LOGOUT</span>
                </g:link>
              </sec:ifLoggedIn>

            </div>
          </div>
        </div>
      </div>
      </header> 

    </div>
    
    
  

    
  
  
</body>
  
<style>


body {
    width: 100%;
    height: 100%;
    font-family: Lora,"Helvetica Neue",Helvetica,Arial,sans-serif;
    color: #fff;
    background-color: #000;
}

.searchbox
{
  background-color:black;
}

.btn btn-danger btn-xs
{
  width: 100%;
}

</style>
</html>