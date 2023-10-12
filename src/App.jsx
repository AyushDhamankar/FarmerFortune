import {useState} from 'react';
import Navbar from './Components/Navbar/Navbar';
import Hero from './Components/Hero/Hero';
import Register from './Components/Register/Register';
import Farmer_Create from './Components/Farmer/Farmer_Create';
import Farmer_Post from './Components/Farmer/Farmer_Post';
import { BrowserRouter as Router,Routes, Route } from 'react-router-dom';

function App() {
  const [state, setState] = useState({
    web3:null,
    contract:null
  })
  const saveState = (state) => {
    console.log(state);
    setState(state);
  }
  return (
    <>
    <Router>
        <Navbar saveState={saveState}></Navbar>
           <Routes>
                <Route exact path='/' element={< Hero />}></Route>
                <Route exact path='/register' element={< Register state={state} />}></Route>
                <Route exact path='/farmer_create' element={< Farmer_Create state={state} />}></Route>
                <Route exact path='/farmer_post' element={< Farmer_Post state={state} />}></Route>
          </Routes>
      </Router>
    </>
  );
}

export default App;