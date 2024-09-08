import java.util.ArrayList; 	
ArrayList<Body> Bodies = new ArrayList<Body>();
void setup() {
	size(3000, 3000); 
	background(0);
}

void draw() {
	float collide = false;
	clear();  //visuals 
	noStroke();
	
	//run against every body for n body simulation
	for(int i = 0; i < Bodies.size(); i++) { 
		Bodies.get(i).display();
		for(int j = i; j < Bodies.size(); j++) {
			if(j != i) {
				Bodies.get(i).attract(Bodies.get(j));
				//combine by weighted average by mass of bodies i and j
				if(Bodies.get(i).checkCollide(Bodies.get(j))) {
					collide = true;
					
					float massRti = Bodies.get(i).m / (Bodies.get(j).m + Bodies.get(i).m);  //mass ratios for collision center of mass;
					float massRtj = Bodies.get(j).m / (Bodies.get(j).m + Bodies.get(i).m);
					
					//solved momentum equations for collided velocity
					float vx3 =  (Bodies.get(i).m * Bodies.get(i).vx + Bodies.get(j).m * Bodies.get(j).vx) / (Bodies.get(i).m + Bodies.get(j).m); 
					float vy3 =  (Bodies.get(i).m * Bodies.get(i).vy + Bodies.get(j).m * Bodies.get(j).vy) / (Bodies.get(i).m + Bodies.get(j).m);
					
					Body cbody = new Body(sqrt(pow(Bodies.get(i).r, 2) + pow(Bodies.get(j).r, 2)), Bodies.get(i).m + Bodies.get(j).m, (massRti * Bodies.get(i).x + massRtj * Bodies.get(j).x), (massRti * Bodies.get(i).y + massRtj * Bodies.get(j).y), vx3, vy3);
					Body rembody = Bodies.get(i);
					Body rembody2 = Bodies.get(j);
				}	
			}
		}
		Bodies.get(i).move();
	}
	//kill the 2 colliding bodies and add the combined body
	if(collide) {
		Bodies.remove(rembody);
		Bodies.remove(rembody2);
		Bodies.add(cbody);
	}
}
//mouse button
void mouseReleased() {
	float ro = random();
	Bodies.add(new Body(ro * 10, abs(ro * 8000), mouseX, mouseY, random() * .9, random() * .9));
}
