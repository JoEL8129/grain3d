float parabola ( float x, float k ) { 
	return pow( 4.0*x*(1.0-x), k ); 
} 

float parabola2 ( float x, float k ) { 
	return 1.0-pow(max(0.0, abs(x)*2 -1.0),k); 
} 

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}