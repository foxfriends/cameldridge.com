function Character(x, y, w, h, color){
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.color = color;
    
    this.drawCharacter = function() {
        context2d.fillStyle = this.color;
        context2d.fillRect(this.x - view.x, this.y - view.y, this.width, this.height);
    }
    this.move = function(direction) {
        const left = -1, right = 1, up = -2, down = 2;
        dist = 8;
        switch(direction) {
            case left:
                if(move && this.x > 0) {
                    this.x -= dist;
                } else {
                    move = 0;
                }
                break;
            case right:
                if(move && this.x < room.width - this.width) {
                    this.x += dist;
                } else {
                    move = 0;
                }
                break;
            case up:
                if(move && this.y > 0) {
                    this.y -= dist;
                } else {
                    move = 0;
                }
                break;
            case down:
                if(move && this.y < room.height - this.height) {
                    this.y += dist;
                } else {
                    move = 0;
                }
                break;
            default:
                break;
        }
        move -= dist;
        if(move <= 0) {
            dir = "";
            move = 0;
        }
    }
    this.getItem = function(item) {
        if(this.x == item.x && this.y == item.y) {
            if(item.type == "coin") {
                score += 1;
                if(BrowserDetect.browser != "Explorer") {
                    playSound(coinWAV);
                } else {
                    playSound(coinMP3);
                }
            } else if(item.type == "life") {
                lives += 1;
                if(BrowserDetect.browser != "Explorer") {
                    playSound(gainLifeWAV);
                }
            }
            return true;
        } else {
            return false;
        }
    }
    this.hitEnemy = function(enemy) {
        if((this.x >= enemy.x && 
            this.x <= enemy.x + 30 && 
            this.y >= enemy.y && 
            this.y <= enemy.y + 30) || (
            enemy.x >= this.x &&
            enemy.x <= this.x + 30 && 
            enemy.y >= this.y && 
            enemy.y <= this.y + 30)) {
            lives -= 1;
            if(BrowserDetect.browser != "Explorer") {
                playSound(loseLifeWAV);
            }
            return true;
        } else {
            return false;
        }
        
    }
}

function Enemy(x,y,w,h,color) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.color = color;
    this.dir = 0;
    this.movementTimer = -4;
    this.drawEnemy = function() {
        context2d.fillStyle = this.color;
        context2d.fillRect(this.x - view.x, this.y - view.y, this.width, this.height);
    }
    this.moveEnemy = function() {
        const right = 1, left = 2, down = 3, up = 4;
        if(this.dir) {
            if(this.dir == 1 && this.x != room.width - 32) {
                this.x += 4;
            } else if(this.dir == 2 && this.x != 0) {
                this.x -= 4;                
            } else if(this.dir == 3 && this.y != room.height - 32) {
                this.y += 4;
            } else if(this.dir == 4 && this.y != 0) {
                this.y -= 4;
            }
            if(this.movementTimer == 0) {
                this.dir = 0;
            }
        } else {
            if(this.movementTimer == -4) {
                this.dir = randomInteger(0,4);
                if(this.x == 0) {
                    if(this.y == 0) {
                        while(this.dir == up || this.dir == left) {
                            this.dir = randomInteger(0,4);
                        }
                    } else if(this.y == room.height - 32) {
                        while(this.dir == down || this.dir == left) {
                            this.dir = randomInteger(0,4);
                        }
                    } else {
                        while(this.dir == left) {
                            this.dir = randomInteger(0,4);
                        }
                    }
                } else if(this.x == room.width - 32) {
                    if(this.y == 0) {
                        while(this.dir == up || this.dir == right) {
                            this.dir = randomInteger(0,4);
                        }
                    } else if(this.y == room.height - 32) {
                        while(this.dir == down || this.dir == roght) {
                            this.dir = randomInteger(0,4);
                        }
                    } else {
                        while(this.dir == right) {
                            this.dir = randomInteger(0,4);
                        }
                    }
                } else if(this.y == 0) {
                    while(this.dir == up) {
                        this.dir = randomInteger(0,4);
                    }
                } else if(this.y == room.height - 32) {
                    while(this.dir == down) {
                        this.dir = randomInteger(0,4);
                    }
                }
                this.movementTimer = 8;
            }
        }
        this.movementTimer--;
    }
}

function Item(x, y, type, w, h, color) {
    this.x = x;
    this.y = y;
    this.type = type;
    this.width = w;
    this.height = h;
    this.color = color;
    
    this.drawItem = function() {
        context2d.fillStyle = this.color;
        context2d.fillRect(this.x - view.x, this.y - view.y, this.width, this.height);
    }
}

function View(x,y,w,h,hbor,vbor,follow) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.hbor = hbor;
    this.vbor = vbor;
    this.follow = follow;
    
    this.move = function() {
        if(this.follow.x >= this.x + this.width - this.hbor - this.follow.width) {
            if(this.x + this.width < room.width) {
                this.x = this.follow.x + this.follow.width + this.hbor - this.width;
            } else {
                this.x = room.width - this.width;
            }
        } else if(this.follow.x <= this.x + this.hbor) {
            if(this.follow.x - this.hbor > 0) {
                this.x = this.follow.x - this.hbor;
            } else {
                this.x = 0;
            }
        }
    
        if(this.follow.y >= this.y + this.height - this.vbor - this.follow.height) {
            if(this.y + this.height < room.height) {
                this.y = this.follow.y + this.follow.height + this.vbor - this.height;
            } else {
                this.y = room.height - this.height;
            }
        } else if(this.follow.y <= this.y + this.vbor) {
            if(this.follow.y - this.vbor > 0) {
                this.y = this.follow.y - this.vbor;
            } else {
                this.y = 0;
            }
        }
    }
}

function Room(w,h) {
    this.width = w;
    this.height = h;
}

function HUD(x, y, w, h, backColor, foreColor, font) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.backColor = backColor;
    this.foreColor = foreColor;
    this.font = font;
    
    this.drawHud = function() {
        context2d.fillStyle = this.backColor;
        context2d.fillRect(this.x, this.y, this.w, this.h);
        this.drawScore();
        this.drawLives();
        this.drawMap();
    }
    
    this.drawScore = function() {
        context2d.fillStyle = this.foreColor;
        context2d.font = this.font;
        context2d.fillText("Score: " + score, this.x + 32, this.y + 2 * 32);
    }
    this.drawLives = function() {
        context2d.fillText("Lives:", this.x + 32, this.y + 32 * 3);
        var life = new Image();
        life.src = "http://flyingpenguin.cyberbri.com/HTML5games/RunningSquared/Image/heart.png";
        if(lives <= 5) {
            for(var i = 0; i < lives; i++) {
                context2d.drawImage(life, this.x + 32 * 3 + 32 / 2 * i, this.y + 32 * 2.6);
            }
        } else {
            context2d.drawImage(life, this.x + 32 * 3, this.y + 32 * 2.6);
            context2d.fillText("x" + lives, this.x + 32 * 4 - 8, this.y + 32 * 3)
        }
    }
    this.drawMap = function() {
        context2d.fillStyle = "RGB(30,30,30)";
        drawGrid(4, 4, this.x + 20, this.y + 5 * 32, 4 * room.width / 32, 4 * room.height / 32);
        //Map the player
        context2d.fillStyle = player.color;
        context2d.fillRect(
            this.x + 20 + player.x / 32 * 4 + 1,
            this.y + 5 * 32 + player.y / 32 * 4 + 1,
            3, 3);
        //Map items
        for(var i = 0; i < items.length; i++) {
            context2d.fillStyle = items[i].color;
            context2d.fillRect(
                this.x + 20 + items[i].x / 32 * 4 + 1,
                this.y + 5 * 32 + items[i].y / 32 * 4 + 1,
                3, 3);
        }
        //Map enemies
        for(i = 0; i < enemies.length; i++) {
            context2d.fillStyle = enemies[i].color;
            context2d.fillRect(
                this.x + 20 + enemies[i].x / 32 * 4 + 1,
                this.y + 5 * 32 + enemies[i].y / 32 * 4 + 1,
                3, 3);
        }
    }
}