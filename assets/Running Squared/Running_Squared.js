include('http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/RunSqObjs.js');
const FPS = 30;
var canvas = null;
var context2d = null;
function init() {
    canvas = document.getElementById('gameCanvas');
    context2d = canvas.getContext('2d');
    canvas.width = 32 * 11 + 200;
    canvas.height = 32 * 11;
    canvas.style.background = "#000";
    needsSetUp = true;
    coinMP3 = addSound("http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/Audio/coin.mp3");
    coinWAV = addSound("http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/Audio/coin.wav");
    loseLifeWAV = addSound("http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/Audio/loseLife.wav");
    gainLifeWAV = addSound("http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/Audio/gainLife.wav");
    highscoreName = "runningSquared";
    loadHighscores(highscoreName);
    currentScreen = "titleScreen";
    runStep = setInterval(step, 1000/FPS);
}
function newCoin() {
    if(items.length < 40) {
        var x,y;
        while(x == undefined) {
            x = randomInteger(0, room.width / 32 - 1) * 32;
            y = randomInteger(0, room.height / 32 - 1) * 32;
            for(var i = 0; i < items.length; i++){
                if(x == items[i].x && y == items[i].y) {
                    x = undefined;
                    i = items.length;
                }
            }
        }
        items[items.length] = new Item(x,y,"coin",32,32,"yellow");
    }
}
function newLife() {
    if(items.length < 40) {
        var x,y;
        while(x == undefined) {
            x = randomInteger(0, room.width / 32 - 1) * 32;
            y = randomInteger(0, room.height / 32 - 1) * 32;
            for(var i = 0; i < items.length; i++){
                if(x == items[i].x && y == items[i].y) {
                    x = undefined;
                    i = items.length;
                }
            }
        }
        items[items.length] = new Item(x,y,"life",32,32,"red");
    }
}
function newEnemy() {
    if(enemies.length < 40) {
        var x,y;
        while(x == undefined) {
            x = randomInteger(0, room.width / 32 - 1) * 32;
            y = randomInteger(0, room.height / 32 - 1) * 32;
            if((x <= player.x + 32 * 3 && x >= player.x - 32 * 3) && (y <= player.y + 32 * 3 && y >= player.y - 32 * 3)) {
                x = undefined;
            }
        }
        enemies[enemies.length] = new Enemy(x,y,32,32,"purple");
    }
}
function setUpRoom(){
    switch(currentScreen) {
        case "titleScreen":
            flashTimer = 40;
            break;
        case "gameStage":
            lives = 3;
            score = 0;
            items = new Array();
            enemies = new Array();
            player = new Character(5 * 32, 5 * 32, 32, 32, "orange");
            move = 0;
            dir = 0;
            view = new View(0, 0, 32 * 11, 32 * 11, 32 * 5, 32 * 5, player);
            room = new Room(32*40,32*40);
            hud = new HUD(canvas.width - 200, 0, 200, canvas.height,"RGB(15,15,15)", "white", "12pt consolas");
            makeNewCoins = setInterval(newCoin, 3000);
            makeNewLife = setInterval(newLife, 60000);
            makeNewEnemy = setInterval(newEnemy, 5000);
            break;
        case "loseScreen":
            flashTimer = 40;
            items = [];
            enemies = [];
            makeNewCoins = "";
            makeNewLife = "";
            makeNewEnemy = "";
            sendScoreResult = "";
            scoreSent = false;
            break;
        default:
            break;
    }
}
function step() {
    if(needsSetUp) {
        setUpRoom();
        needsSetUp = false;
    }
    switch(currentScreen) {
        case "titleScreen":case "loseScreen":
            flashTimer--;
            if(keyboardCheck('enter')) {
                currentScreen = "gameStage";
                needsSetUp = true;
            }
            if(currentScreen == "loseScreen") {
                if(score >= 100) {
                    giveAchievement('RunSq_100_points');
                }
                if(scoreSent == false) {
                    if(keyboardCheck('space')) {
                        if(document.getElementById('loginStatus').innerHTML != "") {
                            sendHighscore(highscoreName, score);
                            sendScoreResult = "Score sent";
                            scoreSent = true;
                        } else {
                            sendScoreResult = "You must be logged in to send scores";
                        }
                    }
                }
            }
            break;
        case "gameStage":
            if(!dir) {
                move = 32;
                hdir = keyboardCheck("right") - keyboardCheck("left");
                vdir = 2 *(keyboardCheck("down") - keyboardCheck("up"));
                if(hdir && vdir) {
                    if(currentDir == "v") {
                        hdir = 0;
                    } else if(currentDir == "h") {
                        vdir = 0;
                    }
                }
                if(hdir) {
                    dir = hdir;
                    currentDir = "h";
                } else if(vdir) {
                    dir = vdir;
                    currentDir = "v";
                } else {
                    dir = 0;
                    currentDir = "";
                }
            }
            player.move(dir);
            for(var i = 0;i < items.length; i++) {
                if(player.getItem(items[i])) {
                    items.splice(i,1);
                }
            }
            for(i = 0; i < enemies.length; i++) {
                enemies[i].moveEnemy();
            }
            for(i = 0;i < enemies.length; i++) {
                if(player.hitEnemy(enemies[i])) {
                    enemies.splice(i,1);
                }
            }
            view.move();
            if(lives == 0) {
                currentScreen = "loseScreen";
                needsSetUp = true;
            }
            break;
        default:
            break;
    }
    draw();
}
function draw() {    
    //Clear the view
    context2d.clearRect(0, 0, canvas.width, canvas.height);
    var text;
    var xPos = canvas.width / 2;
    switch(currentScreen) {
        case "titleScreen":
            //Middle ground 
            context2d.textAlign = 'center';
            context2d.fillStyle = 'white';
            context2d.font = "40px consolas";
            text = "Running Squared";
            context2d.fillText(text, xPos, 3 * 32);
            context2d.font = "20px consolas";
            text = "You are orange. Your goals:";
            context2d.fillText(text, xPos, 4 * 32);
            text = "1. Collect coins (yellow) and lives (red)";
            context2d.fillText(text, xPos, 5 * 32);
            text = "2. Avoid enemies (purple)";
            context2d.fillText(text, xPos, 6 * 32);
            text = "Use arrow keys to move";
            context2d.fillText(text, xPos, 7 * 32);
            if(flashTimer < 25) {
                text = "Press Enter to start";
                context2d.fillText(text, xPos, 8 * 32);
                if(flashTimer == 0) {
                    flashTimer = 40;
                }
            }
            break;
        case "gameStage":
            //Background
            context2d.textAlign = 'left';
            tileBG("RGB(7,7,7)", true, room.width, room.height, 32, 32);
            //Middle ground
            for(var i = 0; i < items.length; i++) {
                items[i].drawItem();
            }
            for(i = 0; i < enemies.length; i++) {
                enemies[i].drawEnemy();
            } 
            //Foreground
            player.drawCharacter();
            hud.drawHud();
            break;
        case "loseScreen":
            //Middle ground
            context2d.textAlign = 'center';
            context2d.fillStyle = 'white';
            context2d.font = "20px consolas";
            text = "Your final score: " + score;
            context2d.fillText(text, xPos, 3 * 32);
            text = "Send score? (press space)";
            context2d.fillText(text, xPos, 4 * 32);
            context2d.fillText(sendScoreResult, xPos, 6 * 32);
            if(flashTimer < 25) {
                text = "Press Enter to retry";
                context2d.fillText(text, xPos, 8 * 32);
                if(flashTimer == 0) {
                    flashTimer = 40;
                }
            }
            break;
        default:
            break;
    }
}
function tileBG(toTile, alternate, width, height, tileWidth, tileHeight) {
    if(alternate) {
        context2d.fillStyle = toTile;
        for(y = 0; y < height; y += tileHeight) {
            for(x = ((y / tileHeight) % 2) * tileHeight; x < width; x += tileWidth * 2) {
                context2d.fillRect(x - view.x, y - view.y, tileWidth, tileHeight);
            }
        }
    } else {
        context2d.fillStyle = toTile;
        for(x = 0; x < width; x += tileWidth) {
            for(y = 0; y < height; y += tileHeight) {
                context2d.fillRect(x - view.x, y - view.y, tileWidth, tileHeight);
            }
        }
    }
}
init();