export const stages = [
    {target: 10, duration: "5s"}, // Ramp-up
    {target: 10, duration: "15s"},
    {target: 50, duration: "5s"}, // Spike occur
    {target: 10, duration: "5s"}, // Spike resolve
    {target: 10, duration: "15s"}, // Normalize
    {target: 0, duration: "5s"} // Close
]