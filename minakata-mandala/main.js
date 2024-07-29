const WIDTH = 400;
const HEIGHT = 400;
let cx = WIDTH / 2;
let cy = HEIGHT / 2;

let x, y;
let rX = 100 * 1.4;
let rY = 80 * 1.4;
let angle = 180;
let count = 0;

let centerColorR = Math.random() * 255;;
let centerColorG = Math.random() * 255;;
let centerColorB = Math.random() * 255;;
let lineColorR = 255;
let lineColorG = 255;
let lineColorB = 255;

let g = null;
let g2 = null;
let container = null;

const fadeIn = () => {
    const opacity = (parseFloat(container.style.opacity) || 1.0) + 0.01;
    if (opacity < 1) {
        container.style.opacity = opacity > 1 ? 1 : opacity;
        window.requestAnimationFrame(fadeIn);
    } else {
        container.style.opacity = 1.0;
    }
}

const fadeOut = () => {
    const opacity = (parseFloat(container.style.opacity) || 1.0) - 0.01;
    if (opacity > 0) {
        container.style.opacity = opacity < 0 ? 0 : opacity;
        window.requestAnimationFrame(fadeOut);
    } else {
        g2.clearRect(0, 0, WIDTH, HEIGHT);
        x1 = Math.random() * WIDTH;
        y1 = HEIGHT;
        xv = Math.random() * (x1 > WIDTH / 2 ? 1 : -1) * 0.3;
        yv = Math.random();
        fadeIn();

        angle = 180;
        rX = 100 * 2;
        rY = 80 * 2;
        x = rX * Math.cos(angle / 180 * Math.PI) + cx;
        y = rY * Math.sin(angle / 180 * Math.PI) + cy;
        draw();
    }
}

const draw = () => {
    // g.clearRect(0, 0, WIDTH, HEIGHT);

    if (count > 600) {
        count = 0;
        centerColorR = Math.random() * 255;
        centerColorG = Math.random() * 255;
        centerColorB = Math.random() * 255;
        return;
    }
    count++;
    rX -= 0.7 * 2;
    rY -= 0.3 * 2;

    // centerColorR = (centerColorR + Math.random() * 10) % 255;
    // centerColorG = (centerColorG + Math.random() * 10) % 255;
    // centerColorB = (centerColorB + Math.random() * 10) % 255;
    // if (centerColorR < 100) {
    //     centerColorR += 100;
    // }
    g.strokeStyle = `rgb(${centerColorR}, ${centerColorG}, ${centerColorB})`;

    g.beginPath();
    g.lineWidth = 1.2;
    g.moveTo(x, y);

    x = rX * Math.cos(angle / 180 * Math.PI) + cx;
    y = rY * Math.sin(angle / 180 * Math.PI) + cy;

    g.lineTo(x, y);
    g.stroke();
    g.closePath();

    angle = (angle + 5) % 360;

    window.requestAnimationFrame(draw, 20);
};

let x1 = Math.random() * WIDTH;
let y1 = HEIGHT;
let xv = Math.random() * (x1 > WIDTH / 2 ? 1 : -1) * 0.1;
let yv = Math.random() * 4;

let lineCount = 0;
const drawLine = () => {
    if (lineCount >= 10) {
        lineCount = 0;
        fadeOut();
        // g2.clearRect(0, 0, WIDTH, HEIGHT);
    }

    lineColorR = (lineColorR + Math.random() * 1) % 255;
    lineColorG = (lineColorG + Math.random() * 1) % 255;
    lineColorB = (lineColorB + Math.random() * 1) % 255;
    if (lineColorR < 100) {
        lineColorR += 100;
    }
    g2.fillStyle = `rgb(${lineColorR}, ${lineColorG}, ${lineColorB})`;
    g2.strokeStyle = g2.fillStyle;

    g2.beginPath();
    g2.lineWidth = 1.2;

    g2.moveTo(x1, y1);

    const x2 = x1 - xv * 1.5;
    const y2 = y1 - 3 + yv * 0.5;
    g2.lineTo(x2, y2);
    g2.stroke();
    g2.closePath();
    x1 = x2;
    y1 = y2;

    const imagedata = g.getImageData(x2, y2, 2, 2);
    const res = imagedata.data.reduce((prev, current) => prev + (current > 0 ? 1 : 0), 0);
    if (res > 0) {
        g2.arc(x2, y2, 2, 0 * Math.PI / 180, 360 * Math.PI / 180, false);
        g2.fill();
    }

    if (x2 <= 0 || x2 > WIDTH || y2 <= 0 || y2 > HEIGHT) {
        lineCount++;
        x1 = Math.random() * WIDTH;
        y1 = HEIGHT;
        xv = Math.random() * (x1 > WIDTH / 2 ? 1 : -1) * 0.3;
        yv = Math.random();
    }

    window.requestAnimationFrame(drawLine, 20);
}

window.onload = function () {
    container = document.getElementById('container');

    let canvas1 = document.getElementById('canvas1');
    g = canvas1.getContext('2d');
    draw();

    let canvas2 = document.getElementById('canvas2');
    g2 = canvas2.getContext('2d');
    drawLine();
};
