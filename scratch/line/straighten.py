#!usr/bin/python

#line straightening using linear regression and edge and corner detection

1. start with grid from image and model file with line lengths
2. inputs: grid, model, value for pixels per millimeter

3. square number of pixels
4. perform clustering

5. for each cluster - define boundary
6. move through columns - get graph of number of pixels per column
7. find edge by maximum gradient
8. regress macro edge
9. compare resulting micro edge to database of input lines from model
10. repeat for rows

11. match up image data and model
12. return refined grid of discrete shapes
        
    