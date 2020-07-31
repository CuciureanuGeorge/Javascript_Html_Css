<%--
  Created by IntelliJ IDEA.
  User: LM
  Date: 5/3/2020
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
    <link rel="stylesheet" type="text/css" href="snake.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="button.css">
</head>

<body>

    <%
        if(session.getAttribute("isLogin")==null)
        {
            response.sendRedirect("login.jsp");
        }
    %>

    <h1>Welcome: ${username}</h1>

    <form action="logout" method="post">
        <input type="submit" name="logout" value="Logout">
    </form>

    <canvas id="canvas" width="800" height="550"></canvas>

    <h1 id="ctr">Counter: ${counter}</h1>


</body>
</html>


<script>

    var canvas = document.getElementById("canvas");

    var context = canvas.getContext('2d');
    var size = 40;
    var xEnd = Math.round(canvas.width / size) * size;
    var yEnd = Math.round(canvas.height / size) * size;
    var directionLock = false;
    var date1 = new Date();
    var date2 = null;

    var snake = [
        {x: 0, y:0}
    ];
    var apple = {};
    var rock = [{}];
    var direction = 'right';
    var speed = 200;
    var nr_obst = 5;

    function random(min, max)
    {
        return Math.random() * (max-min) + min;
    }

    function setObstacles()
    {
        for(var i=0; i<nr_obst; i++)
        {
            rock.push({});
            rock[i].x = Math.round(random(size, canvas.width - size) / size) * size;
            rock[i].y = Math.round(random(size, canvas.height - size) / size) * size;
        }
    }

    function setApple()
    {
        apple.x = Math.round(random(size,canvas.width - size) / size) * size;
        apple.y = Math.round(random(size,canvas.height - size) / size) * size;
    }

    function draw()
    {
        context.clearRect(0,0,canvas.width, canvas.height);

        var appleImg = new Image(size,size);
        appleImg.src = 'apple.png';
        context.drawImage(appleImg, apple.x, apple.y, size, size);

        var rockImg = new Image(size, size);
        rockImg.src = "rock.png";

        for(var i=0; i<nr_obst; i++)
        {
            context.drawImage(rockImg, rock[i].x, rock[i].y, size, size);
        }

        for(var i=0; i<snake.length; i+=1)
        {
            var s = snake[i];

            var snakeImg = new Image(size, size);
            snakeImg.src = 'snake.png';
            context.drawImage(snakeImg, s.x, s.y, size, size)
        }

        window.requestAnimationFrame(draw);
    }

    function tick() {
        for (var i = snake.length - 1; i >= 0; i--) {
            if (i === 0 && snake[i].x === apple.x && snake[i].y === apple.y) {
                snake.push({});
                speed *= 0.90;
                setApple();
            }

            for (var j = 0; j < nr_obst; j++) {
                if (i === 0 && snake[i].x === rock[j].x && snake[i].y === rock[j].y) {
                    date2 = new Date();

                    var xhtml = new XMLHttpRequest();

                    xhtml.onreadystatechange = function () {

                        if (this.readyState == 4 && this.status == 200)
                        {
                                $.ajax({
                                    url: 'endGame',
                                    type: 'post',
                                    data: {
                                        'time': Math.abs(date2-date1)
                                    }
                                });

                            }
                    };
                    xhtml.open("POST", "endGame",true);
                    xhtml.send();

                    alert('GAME OVER');
                    alert(Math.abs(date2-date1)/1000);
                    window.location.reload();
                }
            }

            var s = snake[i];
            if (i === 0) {
                switch (direction) {
                    case 'right':
                        if (s.x > canvas.width) s.x = 0;
                        s.x += size;
                        break;
                    case 'down':
                        if (s.y > canvas.height) s.y = 0;
                        s.y += size;
                        break;
                    case 'left':
                        if (s.x < 0) s.x = xEnd;
                        s.x -= size;
                        break;
                    case 'up':
                        if (s.y < 0) s.y = yEnd;
                        s.y -= size;
                        break;
                }

                for (var j = 1; j < snake.length; j++) {
                    if (snake[0].x === snake[j].x && snake[0].y === snake[j].y) {
                        date2 = new Date();

                        var xhtml = new XMLHttpRequest();

                        xhtml.onreadystatechange = function () {

                            if (this.readyState == 4 && this.status == 200)
                            {
                                $.ajax({
                                    url: 'endGame',
                                    type: 'post',
                                    data: {
                                        'time': Math.abs(date2-date1)
                                    }
                                });

                            }
                        };
                        xhtml.open("POST", "endGame",true);
                        xhtml.send();

                        alert('GAME OVER');
                        alert(Math.abs(date2-date1) / 1000);
                        window.location.reload();
                    }
                }

            } else {
                snake[i].x = snake[i - 1].x;
                snake[i].y = snake[i - 1].y;
            }
        }
        window.setTimeout(tick, speed);
        directionLock = false;
    }

    function onKeyDown(e) {
        var xhtml = new XMLHttpRequest();

        xhtml.onreadystatechange = function () {

            if (this.readyState == 4 && this.status == 200)
            {
                if (!directionLock) {
                    directionLock = true;
                    var newDirection = e.key.substr(5).toLowerCase();

                    $.ajax({
                        url: 'addMove',
                        type: 'post',
                        data: {
                            'dir': newDirection
                        },
                        success: function(data)
                        {
                            console.log(newDirection);
                        }
                    });

                    if (direction === 'left' && newDirection !== 'right') direction = newDirection;
                    if (direction === 'up' && newDirection !== 'down') direction = newDirection;
                    if (direction === 'down' && newDirection !== 'up') direction = newDirection;
                    if (direction === 'right' && newDirection !== 'left') direction = newDirection;
                }
            }
        };

        xhtml.open("POST", "addMove",true);
        xhtml.send();
    }

    setObstacles();
    setApple();
    window.addEventListener('keydown', onKeyDown);
    window.setTimeout(tick, speed);
    window.requestAnimationFrame(draw);
</script>
