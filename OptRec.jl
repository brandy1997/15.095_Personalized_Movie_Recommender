# Personalised Movie Recommender System. JJ.Piao Alessandro Previero

# Import required packages -----------------------------------------------------
using Gurobi, DelimitedFiles, LinearAlgebra, CSV, PyPlot, Random;
using DataFrames, Distributions, MatrixImpute;
plt.style.library["ggplot"]; plt.style.use("ggplot")

# Read in the data -------------------------------------------------------------
movies = CSV.read("movies.csv", header = true)
links = CSV.read("links.csv", header = true)
ratings = CSV.read("ratings.csv", header = true)
tags = CSV.read("tags.csv", header = true)

# Report statistics on the missing entries -------------------------------------
sparseMovies = unstack(ratings, :userId, :movieId, :rating)
colMiss = [count(x->x === missing, sparseMovies[:,i])
          for i =1:size(sparseMovies,2)]./size(sparseMovies,1)*100
rowMiss = [count(x->x === missing, sparseMovies[i,:])
          for i =1:size(sparseMovies,1)]./size(sparseMovies,2)*100

plt.hist(colMiss, bins=30)
xlim(100, 0)
xlabel("Percentage of missing ratings, %")
ylabel("Number of Movies")
gcf()

plt.hist(rowMiss, bins = 30)
xlim(100, 0)
xlabel("Percentage of missing ratings, %")
ylabel("Number of Users")
gcf()

clf()


# PIPELINE
# Output: given a user with some previously seen movies, recommend top 10 movies

# Input: SparseMovie matrix, and MovieFeature matrix

# STEPS
# 1. Perform matrix completion using SparseMovie and MovieFeature
# 2. Develop naïve baseline model, sorting the top 10 scores for each user

# 3. Perform clustering on each user => need to define feature dimenions (cannot
# use individual movies). While varying the number of clusters:

    # 4. Use OCTs to interpret the clusters, until ideal K centroids are defined
# 5.
