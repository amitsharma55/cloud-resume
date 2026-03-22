// Visitor counter - calls API Gateway endpoint
// Replace the API_ENDPOINT with your actual API Gateway URL after deploying
const API_ENDPOINT = "https://YOUR_API_GATEWAY_URL/prod/visitor-count";

async function updateVisitorCount() {
    try {
        const response = await fetch(API_ENDPOINT, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
        });
        const data = await response.json();
        document.getElementById("visitor-count").textContent = data.visitor_count;
    } catch (error) {
        console.error("Error fetching visitor count:", error);
        document.getElementById("visitor-count").textContent = "N/A";
    }
}

// Update count when the page loads
document.addEventListener("DOMContentLoaded", updateVisitorCount);
