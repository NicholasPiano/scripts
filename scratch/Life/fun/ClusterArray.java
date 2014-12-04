import java.util.Random;


public class ClusterArray {

	Random ran = new Random();
	float[][] array;
	float[][] array2;
	int width,height;



	public ClusterArray(int width, int height, float[][] array){
		this.array = array.clone();
		array2 = array.clone();
		this.width = width;
		this.height = height;
	}


	public void roundArray(float[][] a){
		this.array = a.clone();
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				if (array[i][j]<0.1f){
					array2[i][j] = 0.1f;
					continue;
				} else if (array[i][j]<0.2f){
					array2[i][j] = 0.2f;
					continue;
				} else if (array[i][j]<0.3f){
					array2[i][j] = 0.3f;
					continue;
				} else if (array[i][j]<0.4f){
					array2[i][j] = 0.4f;
					continue;
				} else if (array[i][j]<0.5f){
					array2[i][j] = 0.5f;
					continue;
				} else if (array[i][j]<0.6f){
					array2[i][j] = 0.6f;
					continue;
				} else if (array[i][j]<0.7f){
					array2[i][j] = 0.7f;
					continue;
				} else if (array[i][j]<0.8f){
					array2[i][j] = 0.8f;
					continue;
				} else if (array[i][j]<0.9f){
					array2[i][j] = 0.9f;
					continue;
				} else if (array[i][j]<=1.0f){
					array2[i][j] = 1.0f;
					continue;
				} 
			}
		}
	}


	public void clusterArray(float[][] a){
		this.array = a.clone();
		for (int i=1; i<height-1;i++){
			for (int j=1;j<width-1;j++){
				float sum = 0.0f;
				if(i==0){
					sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j];
				} else if (i==height-1){
					sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
				} else if (j==0){
					sum = array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j];
				} else if (j==width-1){
					sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j];
				} else {
					sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j];
				}
				float average = sum/9.0f;
				array[i][j] = average;
			}
		}
	}


	public void clusterArray2(float[][] a){
		this.array = a.clone();
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				float divisor = 9.0f;
				float sum = 0.0f;
				try {
					sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
				} catch (IndexOutOfBoundsException e){
					if(i==0 && j==0){
						sum = array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
						divisor = 4.0f;
					} else if(i==0 && j==width-1){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j];
						divisor = 4.0f;
					} else if (i==height-1 && j==0){
						sum = array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
						divisor = 4.0f;
					} else if (i==height-1 && j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j];
						divisor = 4.0f;
					} else if(i==0){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
						divisor = 6.0f;
					} else if (i==height-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
						divisor = 6.0f;
					} else if (j==0){
						sum = array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
						divisor = 6.0f;
					} else if (j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j];
						divisor = 6.0f;
					}	
				}
				float average = sum/divisor;
				array2[i][j] = average;
			}
		}
	}


	public void clusterArray2Wrong(float[][] a){
		this.array = a.clone();
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				float divisor = 9.0f;
				float sum = 0.0f;
				try {
					sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
				} catch (IndexOutOfBoundsException e){
					if(i==0 && j==0){
						sum = array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
					} else if(i==0 && j==width-1){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j];
					} else if (i==height-1 && j==0){
						sum = array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
					} else if (i==height-1 && j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j];
					} else if(i==0){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
					} else if (i==height-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
					} else if (j==0){
						sum = array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
					} else if (j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j];
					}	
				}
				float average = sum/divisor;
				array2[i][j] = average;
			}
		}
	}


	public void clusterArrayRandom(float[][] a){
		this.array = a.clone();
		for (int i=1; i<height-1;i++){
			for (int j=1;j<width-1;j++){
				float sum = 0.0f;
				float divisor = 9.0f;
				sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j];
				float average = sum/divisor;
				array[i][j] = average;
			}
		}
	}

	public void clusterArray2Random(float[][] a, double chance){
		this.array = a.clone();
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				float divisor = 9.0f;
				float sum = 0.0f;
				try {
					sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
				} catch (IndexOutOfBoundsException e){
					if(i==0 && j==0){
						sum = array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
						divisor = 4.0f;
					} else if(i==0 && j==width-1){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j];
						divisor = 4.0f;
					} else if (i==height-1 && j==0){
						sum = array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
						divisor = 4.0f;
					} else if (i==height-1 && j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j];
						divisor = 4.0f;
					} else if(i==0){
						sum = array[i][j-1]+array[i+1][j-1]+array[i][j]+array[i+1][j]+array[i][j+1]+array[i+1][j+1];
						divisor = 6.0f;
					} else if (i==height-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i-1][j]+array[i][j]+array[i-1][j+1]+array[i][j+1];
						divisor = 6.0f;
					} else if (j==0){
						sum = array[i-1][j]+array[i][j]+array[i+1][j]+array[i-1][j+1]+array[i][j+1]+array[i+1][j+1];
						divisor = 6.0f;
					} else if (j==width-1){
						sum = array[i-1][j-1]+array[i][j-1]+array[i+1][j-1]+array[i-1][j]+array[i][j]+array[i+1][j];
						divisor = 6.0f;
					}	
				}
				float average = sum/divisor;
				if (ran.nextDouble()>chance){
					array2[i][j] = ran.nextFloat();
				} else {
					array2[i][j] = average;
				}
			}
		}
	}


	public void maxArray(float[][] a){
		this.array = a.clone();
		for (int i=1; i<height-1;i++){
			for (int j=1;j<width-1;j++){
				float max = array[i][j];
				if(array[i-1][j-1]>max){
					max = array[i-1][j-1];
				} else if (array[i][j-1]>max){
					max = array[i][j-1];
				} else if (array[i+1][j-1]>max){
					max = array[i+1][j-1];
				} else if (array[i-1][j]>max){
					max = array[i-1][j];
				} else if (array[i+1][j]>max){
					max = array[i+1][j];
				} else if (array[i-1][j+1]>max){
					max = array[i-1][j+1];
				} else if (array[i][j+1]>max){
					max = array[i][j+1];
				} else if (array[i+1][j]>max){
					max = array[i+1][j];
				}
				array[i][j] = max;
			}	
		}
	}


	public void maxArray2(float[][] a){
		this.array = a.clone();
		float[][] temp = new float[height][width];
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){

				try{
					float mx = array[i][j];
					for (int l=i-1;l<i+2;l++){
						for (int m=j-1;m<j+2;m++){
							if(mx<array[l][m]){
								mx = array[l][m];
							}
						}
					}
					temp[i][j] = mx;


				} catch (IndexOutOfBoundsException e){
					if(i==0 && j==0){ 
						float mx = array[i][j];
						for (int l=i;l<i+2;l++){
							for (int m=j;m<j+2;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if(i==0 && j==width-1){
						float mx = array[i][j];
						for (int l=i;l<i+2;l++){
							for (int m=j-1;m<j+1;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if (i==height-1 && j==0){
						float mx = array[i][j];
						for (int l=i-1;l<i+1;l++){
							for (int m=j;m<j+2;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if (i==height-1 && j==width-1){
						float mx = array[i][j];
						for (int l=i-1;l<i+1;l++){
							for (int m=j-1;m<j+1;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if(i==0){
						float mx = array[i][j];
						for (int l=i;l<i+2;l++){
							for (int m=j-1;m<j+2;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if (i==height-1){
						float mx = array[i][j];
						for (int l=i-1;l<i+1;l++){
							for (int m=j-1;m<j+2;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if (j==0){
						float mx = array[i][j];
						for (int l=i-1;l<i+2;l++){
							for (int m=j;m<j+2;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					} else if (j==width-1){
						float mx = array[i][j];
						for (int l=i-1;l<i+2;l++){
							for (int m=j-1;m<j+1;m++){
								if(mx<array[l][m]){
									mx = array[l][m];
								}
							}
						}
						temp[i][j] = mx;

					}	
				}
			}	
		}
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				array2[i][j] = temp[i][j];

			}
		}
	}
	
	public void moveUpArray2(float[][] a){
		array = a.clone();
		float[] temp = new float[width];
		
		for (int k=0;k<width;k++){
			temp[k] = array[0][k];
		}
		
		for (int i=0; i<height-1;i++){
			for (int j=0;j<width;j++){
				array2[i][j] = array[i+1][j];
				
			}
		}
		
		for (int k=0;k<width;k++){
			array2[height-1][k] = temp[k];
		}
		
	}
		
	public void moveDownArray2(float[][] a){
		array = a.clone();
		float[] temp = new float[width];
		
		for (int k=0;k<width;k++){
			temp[k] = array[height-1][k];
		}
		
		for (int i=height-1; i>0;i--){
			for (int j=0;j<width;j++){
				array2[i][j] = array[i-1][j];
				
			}
		}
		
		for (int k=0;k<width;k++){
			array2[1][k] = temp[k];
		}
		
	}
	
	public void moveLeftArray2(float[][] a){
		array = a.clone();
		float[] temp = new float[height];
		
		for (int k=0;k<height;k++){
			temp[k] = array[k][0];
		}
		
		for (int i=0; i<width-1;i++){
			for (int j=0;j<height;j++){
				array2[j][i] = array[j][i+1];
				
			}
		}
		
		for (int k=0;k<height;k++){
			array2[k][width-1] = temp[k];
		}
		
	}
	public void moveRightArray2(float[][] a){
		array = a.clone();
		float[] temp = new float[height];
		
		for (int k=0;k<height;k++){
			temp[k] = array[k][height-1];
		}
		
		for (int i=width-1; i>0;i--){
			for (int j=0;j<height;j++){
				array2[j][i] = array[j][i-1];
				
			}
		}
		
		for (int k=0;k<height;k++){
			array2[k][0] = temp[k];
		}
		
	}
	


	public float[][] getArray(){
		return array;
	}


	public float[][] getArray2(){
		return array2;
	}


}