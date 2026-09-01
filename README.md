# eePsychometrics

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ekholme.github.io/eePsychometrics.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ekholme.github.io/eePsychometrics.jl/dev/)
[![Build Status](https://github.com/ekholme/eePsychometrics.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/ekholme/eePsychometrics.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/ekholme/eePsychometrics.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/ekholme/eePsychometrics.jl)

This package is a learning project intended to help me review some of the foundations of psychometrics.

## Roadmap

This is a loose/WIP roadmap for the package

### Phase 1 - Basic Scoring & Classical Test Theory

- total scores and mean scores (DONE)
- CTT item difficulty (DONE)
- CTT item discrimination (DONE)
- Reliability coefficients (cronbach's alpha (DONE), KR20 (DONE), McDonald's omega, coefficient H)
- Standard error of measurement (SEM) (DONE)
- Write tests for the above (MOSTLY DONE)

### Phase 2 - IRT Core Probabilities

Estimate item response functions for different model types (e.g. 1pl, 2pl, 3pl)

- `prob(item, theta)`: compute item success probability given theta
- `item_information(item, theta)`: compute the item information I(theta)
- `test_information(item_bank, theta)`: compute the test information for a given item bank (simply the sum of all of the item infos)
- `expected_score(item_bank, theta)`: compute test characteristic curve values
- Write tests for the above

### Phase 3 - Person Ability Estimation (Trait Scoring)

Estimate individual ability (theta) assuming item parameters (a, b, c) are already known

- Use maximum likelihood estimation and a proven solver in Julia (e.g. Optim.jl)
- Consider expected a priori or maximum a priori estimation

### Phase 4 - Item Parameter Calibration

Estimate item parameters from response data matrices

- joint maximimum likelihood for Rasch/1pl models
- marginal maximum likelihood using EM algorithm for 2pl/3pl

### Phase 5 - Diagnostics

- TBD. Need to read more