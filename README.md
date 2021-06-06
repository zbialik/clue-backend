# Clue API

Backend HTTP Service for playing a lite-version of clue (board game)

System Breakdown:
- 1 AWS API Gateway
- n AWS Lamda Functions
- 1 DynamoDB Table

<!-- 
Service Endpoints:
    /games
        /_id_
            /actions
                /start-game
                /move
                /complete-turn
                /suggest
                /reveal
                /accept-reveal
                /accuse 
-->
