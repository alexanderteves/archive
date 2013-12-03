#!/usr/bin/python
import os
from time import sleep
from itertools import repeat
from ast import literal_eval
import argparse

DIMENSION = 50
GENERATIONS = 50
TIME = 0.1

parser = argparse.ArgumentParser(description='Play the "Game of Life"')
parser.add_argument('-D', default=DIMENSION, dest='dimension', metavar='DIMENSION', help='The dimension of the field', type=int)
parser.add_argument('-G', default=GENERATIONS, dest='generations', metavar='GENERATIONS', help='Number if generations to be simulated', type=int)
parser.add_argument('-T', default=TIME, dest='time', metavar='SECONDS', help='Seconds between generations (e.g. 0.5 = 500ms)', type=float)
parser.add_argument('File', help='Text file that holds the coordinates (see doc for more help)')

def getNewField(currentField):
    newField = []
    for n in range(DIMENSION): newField.append(list(repeat(0,DIMENSION)))

    for row in range(DIMENSION):
        for cell in range(DIMENSION):
            if getLife(row, cell, currentField): newField[row][cell] = 1

    return newField

def getNeighbours(row, cell):
    # Calculate the coordinates of the eight sourrounding cells
    neighbours = []
    neighbours.append((row-1,cell-1))
    neighbours.append((row-1,cell))
    neighbours.append((row-1,cell+1))
    neighbours.append((row,cell-1))
    neighbours.append((row,cell+1))
    neighbours.append((row+1,cell-1))
    neighbours.append((row+1,cell))
    neighbours.append((row+1,cell+1))
    return neighbours

def getLife(row, cell, field):
    if field[row][cell] == 0: cellAlive = False
    elif field[row][cell] == 1: cellAlive = True

    liveCounter = 0
    neighbours = getNeighbours(row, cell)
    for c in neighbours:
        if c[0] < 0 or c[0] >= DIMENSION or c[1] < 0 or c[1] >= DIMENSION: continue # Cells outside of the field will be treated as dead
        if field[c[0]][c[1]] == 1: liveCounter += 1
    
    # The 'Game of life' rules
    if not cellAlive and liveCounter == 3: return True
    elif cellAlive and liveCounter < 2: return False
    elif cellAlive and (liveCounter == 2 or liveCounter == 3): return True
    elif cellAlive and liveCounter > 3: return False

def fillField():
    mainField = []
    for n in range(DIMENSION): mainField.append(list(repeat(0,DIMENSION)))

    with open(INPUTFILE, 'r') as f:
        while True:
            line = f.readline()
            if line:
                item = literal_eval(line)
                for coordinates in item:
                    mainField[coordinates[0]][coordinates[1]] = 1
            else: break

    return mainField

if __name__ == '__main__':
    try:
        args = parser.parse_args()
        DIMENSION = args.dimension # No given in CLI essentially makes this DIMENSION = DIMENSION, but I don't care ATM
        GENERATIONS = args.generations
        TIME = args.time
        INPUTFILE = args.File
        mainField = fillField()
        # Print the matrix on the screen
        for n in range(GENERATIONS):
            mainField = getNewField(mainField)
            os.system('clear')
            for row in mainField:
                print ''.join(str(i).replace('0','.').replace('1','#') for i in row)
            sleep(TIME)
    except Exception, e: # Gonna catch 'em all!
        print(e)
