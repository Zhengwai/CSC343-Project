from scipy import optimize as opt
import numpy as np
import matplotlib.pyplot as plt
def fct1(x, a,b):
    return np.exp(a*x) + b
def fct2(x, a):
    return a*x**2
def fct3(x, a):
    return a*x
y1 = np.array([4, 5, 0, 5, 13, 13, 13, 59, 165])
x1 = np.arange(9)+1
ppt1, pcov1 = opt.curve_fit(fct1, x1, y1)
print(ppt1)
print(pcov1[0][1], pcov1[1][0])
plt.plot(x1,y1, 'o')
plt.xlabel("# of half centuries from 1600")
plt.ylabel("Number of discoveries")
sx1 = np.arange(100)*0.1
plt.plot(sx1,fct1(sx1, ppt1[0], ppt1[1]))
plt.show()
plt.close()
"""
1) The graph shows that the number of astronomical bodies discovered in solar system grows rapidly (exponentially) 
over time. The number of bodies discovered in 21st century is more than the number before combined.
query used to get the data:
"""
arr = np.array([(1210.0, 6.7635660437875e+18), (60200.0, 1.68434666203811e+22), (5030.0, 1.17431475501367e+20), (11.39, 590526691047484.0), (5.556, 111406302401408.0), (800.0, 3.68668786436323e+18), (4250.0, 8.39378815490672e+19), (21380.0, 2.12346996889279e+21), (11190.0, 5.81534946816655e+20), (2380.0, 2.62293433009359e+19), (1380.0, 8.85413793058474e+18), (23560.0, 2.58009558664714e+21), (36090.0, 6.05453195047471e+21), (510.0, 5.81715037247354e+17), (809.0, 2.992084569118e+18), (10360.0, 4.98946018922175e+20)])
x2 = arr[:,0]/10e3
y2 = arr[:,1]/10e20
ppt2, pcov2 = opt.curve_fit(fct2, x2, y2)
plt.plot(x2, y2, 'o')
print(pcov2[0][0])
print(ppt2)
sx2 = np.arange(140)*0.05
plt.plot(sx2, fct2(sx2, ppt2[0]))
plt.xlabel('escape_speed(10e3km/s)')
plt.ylabel('mass/cbrt(volume)(10e20kg/km)')
plt.show()
plt.close()

arr2 = np.array([(0.62, 3510807799591360.0), (0.5, 3089015320282520.0), (8.87, 5.11450773807107e+16), (24.79, 1.49459415438861e+17), (0.28, 360260177323209.0), (0.82, 4722636053844540.0), (0.0057, 32898280456555.7), (3.7, 2.13428329575396e+16), (8.87, 5.19408417062198e+16), (10.44, 6.44994459955362e+16), (9.8, 5.66245718816901e+16), (3.71, 2.14896268706649e+16), (1.62, 9365347808308640.0), (11.15, 6.50004709971981e+16), (0.003, 5171401756147.46), (0.401, 2234790331690980.0)])
x3 = arr2[:,0]
y3 = arr2[:,1]/10e20
ppt3, pcov3 = opt.curve_fit(fct3, x3, y3)
plt.plot(x3, y3, 'o')
print(pcov3[0][0])
print(ppt3)
sx3 = np.arange(100)*0.26
plt.plot(sx3, fct3(sx3, ppt3[0]))
plt.xlabel('gravity(km/s^2)')
plt.ylabel('mass/cbrt(volume)/cbrt(volume) (10e20kg/km^2)')
plt.show()
plt.close()
"""
2)
The first graph shows that mass/radius of the body is proportional to the square of its escape speed.
mass/radius = a*escape**2, a=4.6478*10e-11 m^3/kg/s^2,
since escape = sqrt(2GM/r) (G is the gravitational constant, M is the mass) and Volume = 4/3 pi r^3, 
G = 1/(2*a*cbrt(4/3pi)) = 6.674*10e-11, %error = 0;
The second graph shows that the mass/radius^2 of the body is proportional to its gravity.
mass/cbrt(volume)**2 = a*gravity, a = 5.96267*10e-9,
since gravity = GM/r and volume = 4/3pi r^3, G = 6.454*10e-11, %error = 3.3
Both agrees with the formulae. 
"""
arr3 = np.array([(0.82, 1), (9.8, 1), (0.5, 1), (0.401, 2), (3.71, 2), (0.62, 5), (11.15, 14),(8.87, 27), (24.79, 79),(10.44, 85)])
x4 = arr3[:,0]
y4 = arr3[:,1]
plt.plot(x4, y4, 'o')
plt.xlabel('gravity')
plt.ylabel('number of satellites')
plt.show()
"""3) The graph shows that the number of satellites of a planet is positively correlated with its gravity.
However, the correlation is not strong meaning that gravity is only one of the factors that can affect a 
planet's number of satellites.
How about satellite 
"""