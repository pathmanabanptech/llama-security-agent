import React, { useEffect } from 'react';
import axios from 'axios';

function App() {
  useEffect(() => {
    // A vulnerable version of axios being used in a standard way
    axios.get('https://api.example.com/data')
      .then(res => console.log(res.data));
  }, []);

  return (
    <div className="App">
      <h1>Security Agent Demo</h1>
      <p>This app is running a vulnerable version of Axios.</p>
    </div>
  );
}

export default App;