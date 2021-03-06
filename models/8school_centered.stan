
//saved as 8school_centered.stan
data {
  int<lower=0> J;         //number of schools 
  real y[J];              // estimated treatment effects
  real<lower=0> sigma[J]; // sd. error of effect estimates 
  int<lower =0, upper =1> run_estimation; //a switch to evaluate likelihood (=1) or not (=0)
}
parameters {
  real mu; 
  real<lower=0> tau;
  real theta[J];
 }

model {
  //priors
  mu ~ normal(0,5);
  tau ~ cauchy(0,5);
  theta ~ normal(mu, tau);
  
  //evaluate the likelihood conditionally
  if(run_estimation == 1){
    y ~ normal(theta, sigma);
  }
}
generated quantities{
  real y_sim[J]; //array to hold simulated data
 
    for(j in 1:J) {
       y_sim[j] =  normal_rng(theta[j], sigma[j]);
    }
}
