import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt
from matplotlib.ticker import AutoMinorLocator

X = np.array([])
Y = np.array([])

def func(X, param):
    return 0

popt, pcov = curve_fit(func, X, Y)
param = popt[0]

fig = plt.figure(num=1)
ax = fig.add_subplot(1, 1, 1)
ax.xaxis.set_minor_locator(AutoMinorLocator())
ax.yaxis.set_minor_locator(AutoMinorLocator())
ax.tick_params(which='minor', width=0.5, length=3)
ax.tick_params(which='both', top=True, right=True)
ax.grid(which='major', linestyle='--')
ax.grid(which='minor', linestyle='dotted')

ax.plot( X, Y, marker='.', linestyle='', label="Experimental Data")
X_ = np.linspace(0, 0, 1000)
Y_ = func(X_, param)
ax.plot(X_, Y_, label="Best Fit Curve")

xmin = min(X.min(), X_.min())
xmin *= (xmin > 0)*0.95 + ( xmin < 0)*1.05
xmax = max(X.max(), X_.max())
xmax *= (xmax > 0)*1.05 + ( xmax < 0)*0.95

ymin = min(Y.min(), Y_.min())
ymin *= (ymin > 0)*0.95 + ( ymin < 0)*1.05
ymax = max(Y.max(), Y_.max())
ymax *= (ymax > 0)*1.05 + ( ymax < 0)*0.95

ax.set_xlim(xmin, xmax)
ax.set_ylim(ymin, ymax)
ax.set_xlabel(r"X")
ax.set_ylabel(r"Y")
plt.legend()
plt.savefig("image.png", dpi=600)
