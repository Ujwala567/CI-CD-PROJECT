import React from "react"
import "./App.css"

function App() {
  return (
    <div className="App">
      <header className="header">
        <h1>🚀 CloudNative DeployHub</h1>
        <p>Your Complete CI/CD Platform is Running!</p>
        <button className="test-button" onClick={() => alert("Test!")}>
          Test Deployment Pipeline
        </button>
      </header>
    </div>
  )
}

export default App
