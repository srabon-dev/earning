
// Html Design Here, In case the URL not showing then This Html Design will show (a 404 Error Screen)
const String errorHtmlText = """<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 Not Found</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(45deg, #5ec7d3, #9b59b6);
            color: #fff;
            text-align: center;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        .animated-bubbles {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
            animation: moveBubbles 20s linear infinite;
        }

        .bubble {
            position: absolute;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            animation: floatBubble 5s ease-in-out infinite;
        }

        .error-icon {
            font-size: 5em;
            color: #fff;
        }

        .error-code {
            font-size: 4em;
            font-weight: bold;
            margin: 10px 0;
            animation: shake 0.5s ease-in-out infinite;
        }

        .error-message {
            font-size: 1.5em;
            margin-bottom: 20px;
            opacity: 0;
            animation: fadeIn 1s ease-out forwards;
            animation-delay: 0.5s;
        }

        .back-to-home {
            text-decoration: none;
            background-color: #fff;
            color: #3498db;
            padding: 10px 20px;
            font-size: 1.2em;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            opacity: 0;
            animation: fadeIn 1s ease-out forwards;
            animation-delay: 1s;
        }

        .back-to-home:hover {
            background-color: #e6f7ff;
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }

            25%, 75% {
                transform: translateX(-10px);
            }

            50% {
                transform: translateX(10px);
            }
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        @keyframes floatBubble {
            0% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-20px);
            }

            100% {
                transform: translateY(0);
            }
        }

        @keyframes moveBubbles {
            0% {
                transform: translate(0, 0);
            }

            50% {
                transform: translate(-50%, -50%);
            }

            100% {
                transform: translate(0, 0);
            }
        }
    </style>
</head>

<body>
    <div class="animated-bubbles">
        <!-- Create multiple bubble elements for the animated background -->
        <div class="bubble" style="top: 10%; left: 20%; width: 20px; height: 20px;"></div>
        <div class="bubble" style="top: 40%; left: 60%; width: 15px; height: 15px;"></div>
        <div class="bubble" style="top: 70%; left: 80%; width: 25px; height: 25px;"></div>
        <div class="bubble" style="top: 30%; left: 40%; width: 18px; height: 18px;"></div>
        <div class="bubble" style="top: 60%; left: 90%; width: 22px; height: 22px;"></div>
        <div class="bubble" style="top: 10%; left: 20%; width: 20px; height: 20px;"></div>
        <div class="bubble" style="top: 40%; left: 60%; width: 15px; height: 15px;"></div>
        <div class="bubble" style="top: 70%; left: 80%; width: 25px; height: 25px;"></div>
        <div class="bubble" style="top: 30%; left: 40%; width: 18px; height: 18px;"></div>
        <div class="bubble" style="top: 60%; left: 90%; width: 22px; height: 22px;"></div>
        <div class="bubble" style="top: 10%; left: 20%; width: 20px; height: 20px;"></div>
        <div class="bubble" style="top: 40%; left: 60%; width: 15px; height: 15px;"></div>
        <div class="bubble" style="top: 70%; left: 80%; width: 25px; height: 25px;"></div>
        <div class="bubble" style="top: 30%; left: 40%; width: 18px; height: 18px;"></div>
        <div class="bubble" style="top: 60%; left: 90%; width: 22px; height: 22px;"></div>
        <div class="bubble" style="top: 10%; left: 20%; width: 20px; height: 20px;"></div>
        <div class="bubble" style="top: 40%; left: 60%; width: 15px; height: 15px;"></div>
        <div class="bubble" style="top: 70%; left: 80%; width: 25px; height: 25px;"></div>
        <div class="bubble" style="top: 30%; left: 40%; width: 18px; height: 18px;"></div>
        <div class="bubble" style="top: 60%; left: 90%; width: 22px; height: 22px;"></div>
        <!-- Add more bubbles as needed -->
    </div>

    <div class="container">
        <i class="fas fa-exclamation-circle error-icon"></i>
        <h1 class="error-code">404</h1>
        <p class="error-message">Oops! The page you're looking for could not be found.</p>
        <a href="/" class="back-to-home">Back to Home</a>
    </div>
</body>

</html>""";