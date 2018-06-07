// == Puck variables and functions == //

int puckCoordX;
int puckCoordY;

Point newPosition;
Point lastPosition;

Line incidenceLine;
Line reflectionLine;
Point intersection1;
Point intersection2;

public void trajectoryPrediction() {

  if (puckCoordX == 0 && puckCoordY == 0) return;

  if (frameCount % FRAME_INTERVAL != 0) return;

  lastPosition.setPoint(newPosition.x, newPosition.y);
  newPosition.setPoint(puckCoordX, puckCoordY);

  // Variação de movimento mínima para calcular trajetória
  if (dist(lastPosition.x, lastPosition.y, newPosition.x, newPosition.y) < MIN_DISTANCE) return;

  // Se não for na direção do robô
  if (newPosition.y < lastPosition.y) return;

  // Atualiza equação da linha
  incidenceLine.setLine(lastPosition, newPosition);

  // Ponto de interseção com a linha 0
  intersection1 = Intercept(incidenceLine, viewAreaRect.lines[0]);

  // Checa se intercepta com a linha 0
  if (intersection1.x > viewAreaRect.points[0].x && intersection1.x < viewAreaRect.points[1].x) {
    reflectionLine.setLine(lastPosition, intersection1);

    strokeWeight(2); 
    stroke(#FF0000);
    line(newPosition.x, newPosition.y, intersection1.x, intersection1.y);
  } else {

    // Checa se inclinação
    // Se > 0 (Intercepta com a linha 1)
    // Se < 0 (Intercepta com a linha 3)
    if (incidenceLine.m < 0) {

      // Ponto de interseção com a linha 3
      intersection1 = Intercept(incidenceLine, viewAreaRect.lines[3]);

      float _m = 2*viewAreaRect.lines[3].m/(1-pow(viewAreaRect.lines[3].m, 2));
      float newM = (_m - incidenceLine.m)/(1 + _m*incidenceLine.m);

      // Cria equação da linha refletida
      reflectionLine.setLine(intersection1, newM);

      // Ponto de interseção da linha refletida
      // interseção com linha 0
      intersection2 = Intercept(reflectionLine, viewAreaRect.lines[0]);
      // Checa se intercepta com a linha 0
      if (intersection2.x > viewAreaRect.points[0].x && intersection2.x < viewAreaRect.points[1].x) {
        // ** PONTO DE INTERSEÇÃO FINAL ** //
      } else {

        // interseção com linha 1
        intersection2 = Intercept(reflectionLine, viewAreaRect.lines[1]);  //
      }

      // Senão intercepta, checa com a linha 1
    } else {

      // Ponto de interseção com a linha 1
      intersection1 = Intercept(incidenceLine, viewAreaRect.lines[1]);

      float _m = 2*viewAreaRect.lines[1].m/(1-pow(viewAreaRect.lines[1].m, 2));
      float newM = (_m - incidenceLine.m)/(1 + _m*incidenceLine.m);

      // Cria equação da linha refletida
      reflectionLine.setLine(intersection1, newM);

      // Ponto de interseção da linha refletida
      // interseção com linha 0
      intersection2 = Intercept(reflectionLine, viewAreaRect.lines[0]);
      // Checa se intercepta com a linha 0
      if (intersection2.x > viewAreaRect.points[0].x && intersection2.x < viewAreaRect.points[1].x) {
      } else {

        // interseção com linha 3
        intersection2 = Intercept(reflectionLine, viewAreaRect.lines[3]);
      }
    }

    strokeWeight(2); 
    stroke(#FF0000);
    line(newPosition.x, newPosition.y, intersection1.x, intersection1.y);
    line(intersection1.x, intersection1.y, intersection2.x, intersection2.y);
  }
}

public void drawTrajectoryLines() {

  if (puckCoordX == 0 && puckCoordY == 0) return;

  // Variação de movimento mínima para calcular trajetória
  if (dist(lastPosition.x, lastPosition.y, newPosition.x, newPosition.y) < MIN_DISTANCE) return;

  // Se não for na direção do robô
  if (newPosition.y < lastPosition.y) return;

  strokeWeight(2); 
  stroke(#FF0000);
  line(newPosition.x, newPosition.y, intersection1.x, intersection1.y);
  line(intersection1.x, intersection1.y, intersection2.x, intersection2.y);
}

// == Robot variables == //

int robotCoordX;
int robotCoordY;