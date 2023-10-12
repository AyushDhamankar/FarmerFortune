import { useState, useEffect } from "react";
function Farmer_Post({ state }) {
  const [detail, setDetail] = useState("");
  useEffect(() => {
    const { contract } = state;
    const getDetail = async () => {
      const nameText = await contract.methods.Farmer_Post_Display().call();
      console.log(nameText);
      setDetail(nameText);
    };
    contract && getDetail();
  }, [state]);

  const buyNFT = async (id, value) => {
    try {
      console.log("Hii");
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const { contract } = state;

      const result = await contract.methods
        .buyNFT(id, value)
        .send({ from: accounts[0] });
      console.log(result);
    } catch (error) {
      console.error(error);
      console.log("Bye");
    }
  };
  return (
    <>
      <div
        style={{
          minHeight: "90vh",
          backgroundColor: "#111827",
          display: "flex",
          alignItems: "center",
          flexDirection: "column",
          justifyContent: "center",
        }}
      >
        {detail !== "" &&
          detail.map((detail) => {
            console.log(detail);
            return (
              <div
                class="max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700"
                style={{ marginTop: "10px", marginBottom: "10px" }}
              >
                <a href="#">
                  <img
                    class="rounded-t-lg"
                    src={`https://ipfs.io/ipfs/${detail[4]}`}
                    alt=""
                    width="100%"
                  />
                </a>
                <div class="p-5">
                  <a href="#">
                    <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
                      Name : <span class="mb-3 font-normal text-gray-700 dark:text-white">{detail[2]}</span>
                    </h5>
                    <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
                      Description : <span class="mb-3 font-normal text-gray-700 dark:text-white">{detail[3]}</span>
                    </h5>
                    <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
                      Quantity : <span class="mb-3 font-normal text-gray-700 dark:text-white">{detail[5]} Kg</span>
                    </h5>
                  </a>
                  <button
                    href="#"
                    class="inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                    style={{ marginRight: "20px", marginTop: "5px", fontWeight: "bolder" }}
                    onClick={() => {handleDownload(detail[0], detail[1], detail[4])}}
                  >
                    BUY {detail[6]} ETH
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="mr-2 h-6 w-6"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        stroke-width="2"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"
                        />
                      </svg>
                  </button>
                </div>
              </div>
            );
          })}
      </div>
    </>
  );
}

export default Farmer_Post;
