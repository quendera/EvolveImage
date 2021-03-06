# Run all the code up until the variable definitions to load functions to memory

using TestImages #You don't need this line when using local files
using Images

##### Define the fitness function 


function fitness(a,b)
    score = sqrt(512*512-sum((a - b).^2))
    return score
end

# gets the difference between the value (0 is black, 1 is white) of all pixels in one of the population arrays and the pixels in the target array

function all_fit(pop, t)
    fitness_vec =  zeros(N)
    for i in 1:N
        fitness_vec[i] = fitness(pop[i,:,:], t)
        #println(fitness_vec[i])
    end
    return fitness_vec
end

# Generates a child using parameters set below

function genfilho(cdf,pop,crossover, prob_m, hillclimbing, sigma_hc, dim)
    if prob_m > rand()
        filho = rand(dim[1],dim[2])
    else
        min_val = rand(1)
        cdf[cdf .> min_val]
        index_pai = sum((cdf .< min_val))+1
        pai = pop[index_pai]
        mae = zeros(dim[1],dim[2])
        if crossover
            index_mae = index_pai
            while index_mae == index_pai
                min_val = rand(1)
                cdf[cdf .> min_val]
                index_mae = sum((cdf .< min_val))+1
            end
            mae = pop[index_mae]
        end
        filho = 0.5*pai+0.5*mae
        if hillclimbing
            filho+= sigma_hc*randn(dim[1],dim[2])
        end
    end
    return filho
end

# get the best members of the population
function get_best_members(fitness_vec_prob,pop,N,percentage_best)
    ord_vec = reverse(sortperm(fitness_vec_prob))
    filhos = pop[ord_vec[1:Int(floor(N*percentage_best))],:,:]
    return filhos
end

#Create the next generation

function epoch(pop, dim, target, N, percentage_best, sigma, crossover, prob_m, hillclimbing, sigma_hc)

    top_idx = Int(floor(N*percentage_best))
    fitness_vec = all_fit(pop, target_float)
    println(mean(fitness_vec))
    fitness_vec_prob=(fitness_vec)/sum(fitness_vec)
    cdf = cumsum(fitness_vec_prob)

    new_pop = zeros(N,dim[1], dim[2])
    new_pop[1:top_idx,:,:] = get_best_members(fitness_vec_prob, pop,N, percentage_best)

    num_best_members = Int(floor(N*percentage_best))

    while num_best_members < N
        new_pop[num_best_members,:,:] = (genfilho(cdf,pop,crossover, prob_m, hillclimbing, sigma_hc, dim))
        num_best_members +=1
    end
    return new_pop
end




############################# STOP FIRST RUN HERE #######################

#Show a sample start image
sample_img = rand(512,512)
colorview(Gray, sample_img)


#Define your variables
target = testimage("livingroom")
target_float = float(target) #convert img to array
dim = size(target_float) #get size of array
N = 100 
percentage_best = 0.15
sigma = 0.05
pop = rand(N,dim[1], dim[2]) #empty pop vector
nr_epochs = 300
crossover = true
prob_m = 0.05
hillclimbing = false
sigma_hc = 0.05

#loop all the code "nr_epochs" times

for i in 1:nr_epochs
    colorview(Gray, pop[1,:,:])
    pop = epoch(pop, dim, target_float, N, percentage_best, sigma, crossover, prob_m, hillclimbing, sigma_hc)
end
