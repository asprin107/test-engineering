export const stages = [
    {target: 10, duration: "20s"}, // Ramp-up
    {target: 10, duration: "5m"},
    {target: 50, duration: "5s"}, // Spike occur
    {target: 10, duration: "5s"}, // Spike resolve
    {target: 10, duration: "20m"}, // Normalize
    {target: 0, duration: "20s"} // Close
]