class Body {
	//position variables 
	float x, y; //coordinates 
	
	//motion variables
	float vx, vy; //velocities 
	float a; //total acceleration
	float ax, ay; //component acceleration
	
	//body attributal variables
	float m; //mass of body 
	float r; // radius of body 
	float d; // density of body 
	
  //constants 
	static float G = .009895; //Universal gravitational constant
	static float pi = 3.1415926535; 

	//standard body
	Body() {
	 m = 100;
	 r = 7.5; 
		
	 x = abs(random() * 1000); 
	 y = abs(random() * 1000); 
		
	 vx = random() * 3;
	 vy = random() * 3;
		
	 d = m /(pi * pow(r,2));
	}
	
	//editing body
	Body(float radius, float mass, float xcor, float ycor, float velx, float vely) {
	 m = mass;
	 r = radius; 
		
	 x = xcor;
	 y = ycor; 
		
	 vx = velx; 
	 vy = vely; 
		
	 d = m /(pi * pow(r,2));
	}
	//shows the body on screen; 
	void display() {
		ellipse(x, y, 2*r, 2*r); 
	}
	//calclulates the motion of attraction between 2 bodies.

 //makes the object actually move 
	void move() {
		//change position based on velocity
		x += vx; 
		y += vy;
	}
	void attract(Body b) {
		
		float dist = sqrt(pow(b.y - y, 2) + pow(b.x - x, 2)); //distance formula; 
		
		//acceleration calculations; 
		a = (G * b.m) / (pow(dist, 2));   //Newtons law of Gravitation
		b.a = (G * m) / (pow(dist, 2));
		
		float ang = atan(abs(b.y - y) / abs(b.x - x)); //reference angle between both bodies. 
		
		//unsigned component accelerations 
		ax = a * cos(ang);
		b.ax = b.a * cos(ang); 
		ay = a * sin(ang);  
		b.ay = b.a * sin(ang); 
		
		//signing accelerations
		if(x > b.x)
			ax *= -1; 
		if(b.x > x)
			b.ax *= -1; 
		if(b.y > y )
			b.ay *= -1; 
		if(y > b.y)
			ay *= -1; 
		
		//kinematic formula to increase velocity from acceleration 
		vx += ax; 
		b.vx += b.ax; 
		vy += ay; 
		b.vy += b.ay; 
		
	}



	//If 2 bodies ever collide, return true for it to be processed in the body arraylist
	boolean checkCollide(body b) { 
		float dist = sqrt(pow(b.y - y, 2) + pow(b.x - x, 2));
		return (dist < r + b.r);
	}
}
