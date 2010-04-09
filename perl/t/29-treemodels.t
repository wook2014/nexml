use Test::More 'no_plan';
use strict;
use warnings;
use Bio::Phylo::Util::CONSTANT qw(
    looks_like_object
    looks_like_instance
    _TREE_
    _FOREST_
);

# Test to see if we can require the module we're exercising
require_ok('Bio::Phylo::EvolutionaryModels');

# For convenience we import the sample routine so we can write sample(...) 
# instead of Bio::Phylo::EvolutionaryModels::sample(...).
Bio::Phylo::EvolutionaryModels->import('sample');

# Example A
# Simulate a single tree with ten species from the constant rate birth model
# with parameter 0.5
{
    my $tree = Bio::Phylo::EvolutionaryModels::constant_rate_birth(
        'birth_rate' => .5,
        'tree_size'  => 10
    );
    ok(looks_like_object($tree,_TREE_), "object is a tree");
    my $tipcount = scalar @{ $tree->get_terminals };
    ok(10==$tipcount, "tree has ${tipcount}==10 tips");
}

# Example B
# Sample 5 trees with ten species from the constant rate birth model using
# the b algorithm
{
    my ( $sample, $stats ) = sample(
        'sample_size'       => 5,
        'tree_size'         => 10,
        'algorithm'         => 'b',
        'algorithm_options' => { 'rate' => 1 },
        'model'             => \&Bio::Phylo::EvolutionaryModels::constant_rate_birth,
        'model_options'     => { 'birth_rate' => .5 }
    );
    
    eval {
         # I'd like to make the sample a forest object
        ok( looks_like_object($sample,_FOREST_), "sample is a forest" );
    };
    ok( scalar @{ $sample } == 5, "sample has 5 trees" );
    for my $t ( @{ $sample } ) {
        ok( scalar @{ $t->get_terminals } == 10, "tree has 10 tips" ); 
    }
}

# Example C
# Sample 5 trees with ten species from the constant rate birth and death model
# using the bd algorithm and two threads (useful for dual core processors)
# NB: we must specify an nstar here, an appropriate choice will depend on the
# birth_rate and death_rate we are giving the model
{
    my ( $sample, $stats ) = sample(
        'sample_size'       => 5,
        'tree_size'         => 10,
        'threads'           => 2,
        'algorithm'         => 'bd',
        'algorithm_options' => { 'rate'       => 1, 'nstar'      => 30 },
        'model_options'     => { 'birth_rate' => 1, 'death_rate' => .8 },    
        'model' => \&Bio::Phylo::EvolutionaryModels::constant_rate_birth_death,
    );
    eval {
        # I'd like to make the sample a forest object
        ok( looks_like_object($sample,_FOREST_), "sample is a forest" ); 
    };
    ok( scalar @{ $sample } == 5, "sample has 5 trees" );
    for my $t ( @{ $sample } ) {
        my $count = scalar @{ $t->get_terminals };
        ok( $count == 10, "tree has ${count}==10 tips" );
    }
}

# Example D
# Sample 5 trees with ten species from the constant rate birth and death model
# using incomplete taxon sampling
#
# sampling_probability is set so that the true tree has 10 species with 50%
# probability, 11 species with 30% probability and 12 species with 20%
# probability
#
# NB: we must specify an mstar here this will depend on the model parameters
# and the incomplete taxon sampling parameters
{
    my $algorithm_options = {
        'rate'  => 1, 
        'nstar' => 30, 
        'mstar' => 12,     
        'sampling_probability' => [ .5, .3, .2 ],
    };
                       
    my ( $sample, $stats ) = sample(
        'sample_size'       => 5,
        'tree_size'         => 10,
        'algorithm'         => 'incomplete_sampling_bd',
        'algorithm_options' => $algorithm_options,
        'model_options'     => { 'birth_rate' => 1, 'death_rate' => .8 },
        'model' => \&Bio::Phylo::EvolutionaryModels::constant_rate_birth_death,    
    );
    eval {
        # I'd like to make the sample a forest object
        ok( looks_like_object $sample, _FOREST_ );
    };
    ok( scalar @{ $sample } == 5 );
    for my $t ( @{ $sample } ) {
        my $count = scalar @{ $t->get_terminals };
        ok( $count == 10, "tree has ${count}==10 tips" );
    }    
}

# Example E
# Sample 5 trees with ten species from a Yule model using the memoryless_b
# algorithm
#
# First we define the random function for the shortest pendant edge for a Yule
# model
{
    my $random_pendant_function = sub { 
        my %options = @_;
        return -log(rand) / $options{'birth_rate'} / $options{'tree_size'};
    };
     
    # Then we produce our sample
    my ( $sample, $stats ) = sample(
        'sample_size'       => 5,
        'tree_size'         => 10,
        'algorithm'         => 'memoryless_b',
        'model_options'     => { 'birth_rate'   => 1 },
        'algorithm_options' => { 'pendant_dist' => $random_pendant_function },
        'model' => \&Bio::Phylo::EvolutionaryModels::constant_rate_birth,    
    );
    
    eval {
        # I'd like to make the sample a forest object
        ok( looks_like_object $sample, _FOREST_ );
    };
    ok( scalar @{ $sample } == 5 );
    for my $t ( @{ $sample } ) {
        ok( scalar @{ $t->get_terminals } == 10 );
    }    
}

# Example F
# Sample 5 trees with ten species from a constant birth death rate model using
# the constant_rate_bd algorithm
{
    my ( $sample ) = sample(
        'sample_size'   => 5,
        'tree_size'     => 10,
        'algorithm'     => 'constant_rate_bd',
        'model_options' => { 'birth_rate' => 1, 'death_rate' => .8 }
    );
    eval {
        # I'd like to make the sample a forest object
        ok( looks_like_object $sample, _FOREST_ );
    };
    ok( scalar @{ $sample } == 5 );
    for my $t ( @{ $sample } ) {
        ok( scalar @{ $t->get_terminals } == 10 );
    }
}