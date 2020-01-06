

test_matrix = [[1,2,0],[2,4,5],[7,0,1]]

def max_cheese(cheese_matrix):
    max_i = len(cheese_matrix)
    max_j = len(cheese_matrix[0])

    max_matrix = [ [0 for j in range(max_j)] for i in range(max_i)]

    def how_much_cheese(i,j):
        cheese = cheese_matrix[i][j]
        max_right = max_matrix[i][j+1] if j < (max_j - 1) else 0
        max_down = max_matrix[i+1][j] if i < (max_i - 1) else 0
        return cheese + max(max_right, max_down)
    
    def loop(i,j):
        cheese = how_much_cheese(i,j)
        max_matrix[i][j] = cheese
        if j > 0:
            return loop(i, j-1)
        elif i > 0:
            return loop(i-1,max_j -1)
        else:
            return
    
    loop (max_i -1, max_j -1)
    return max_matrix[0][0]

from functools import lru_cache

def max_cheese2(cheese_matrix):
    max_i = len(cheese_matrix)
    max_j = len(cheese_matrix[0])

    @lru_cache(maxsize = 250)
    def mouse(i,j):
        cheese = cheese_matrix[i][j]
        max_right = mouse(i,j+1) if j < (max_j - 1) else 0
        max_down = mouse(i+1,j) if i < (max_i - 1) else 0
        return cheese + max(max_down, max_right)
    
    return mouse(0,0)