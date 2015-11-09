# Algorithm Basics

## Pricing
For an overview of algorithm pricing, see the [pricing page](https://algorithmia.com/pricing).

Algorithm usage is calculated in Algorithmia Credits. The current exchange rate for purchasing new credits is 10,000 credits to $1 USD.

### Cost of running an algorithm

All algorithms in the marketplace are charged a fee of 1 credit per second (1cr/sec) of execution time on a single dedicated code. The execution time is calculated from the start of the algorithm execution until the algorithm returns.

In addition to the execution charge, algorithm developers may charge a royalty on each algorithm call. This cost-per-call royalty is associated with a specific version of the algorithm and will remain fixed indefinitely.

<aside class="warning">
When an algorithm developer releases a new minor or major version of the algorithm, they have the option to include a pricing change. Make sure to include the version in your algorithm call to ensure a consistent experience.
</aside>

### Algorithms that call other algorithms

Some algorithms build upon other algorithms to create a new service or tool. While this is a powerful way of leveraging the value of multiple algorithms and parallelizing work across the Algorithmia Cluster, such algorithms may incur additional usage costs.

When calling into an algorithm that uses another algorithm internally, you may encounter an additional usage cost at the same 1cr/sec of execution time per core. Additionally, you may incur additional royalty costs if the associated algorithm also charges a royalty.

<aside class="notice">
View your last 30-days of account usage on your account page.
</aside>


## Permissions




## Versioning

