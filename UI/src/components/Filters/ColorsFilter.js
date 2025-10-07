// import React, { useCallback, useState } from 'react';
// import { useSearchParams } from "react-router-dom";

// export const colorSelector = {
//     "Purple":"#8434E1",
//     "Black":"#252525",
//     "White":"#FFFFFF",
//     "Gray": "#808080",
//     "Blue": "#0000FF",
//     "Red": "#FF0000",
//     "Orange": "#FFA500",
//     "Navy": "#000080",
//     "Grey": "#808080",
//     "Yellow": "#FFFF00",
//     "Pink": "#FFC0CB",
//     "Green": "#008000"
// }

// const ColorsFilter = ({colors}) => {

//   const [appliedColors, setAppliedColors] = useState([]);
//   const [searchParams, setSearchParams] = useSearchParams();
//   const onClickDiv = useCallback((item)=>{
//     if(appliedColors.indexOf(item) > -1){
      
//       setAppliedColors(appliedColors?.filter(color => color !== item));
//     }
//     else{
//       setAppliedColors([...appliedColors,item]);
//     }
//   }, [appliedColors, setAppliedColors]);

  
//   console.log(appliedColors)

//   return (
//     <div className='flex flex-col mb-4'>
//         <p className='text-[16px] text-black mt-5 mb-5'>Colors</p>
//         <div className='flex flex-wrap px-2'>
//             {colors?.map(item=> {
//               return (
//                 <div className='flex flex-col mr-2'>
//                   <div className='w-8 h-8 border rounded-xl mr-4 cursor-pointer hover:scale-110' onClick={()=>onClickDiv(item)} style={{background:`${colorSelector[item]}`}}></div>
//                   <p className='text-sm text-gray-400 mb-2' style={{color:`${appliedColors?.includes(item) ? 'black':''}`}}>{item}</p>
//                   </div>
//               )
//             })}
//         </div>
//     </div>
//   )
// }

// export default ColorsFilter

import React, { useCallback, useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";

export const colorSelector = {
  Purple: "#8434E1",
  Black: "#252525",
  White: "#FFFFFF",
  Gray: "#808080",
  Blue: "#0000FF",
  Red: "#FF0000",
  Orange: "#FFA500",
  Navy: "#000080",
  Grey: "#808080",
  Yellow: "#FFFF00",
  Pink: "#FFC0CB",
  Green: "#008000",
};

const ColorsFilter = ({ colors }) => {
  const [appliedColors, setAppliedColors] = useState([]);
  const [searchParams, setSearchParams] = useSearchParams();

  // Lấy màu từ URL khi component mount
  useEffect(() => {
    const colorsFromParams = searchParams.get("colors");
    if (colorsFromParams) {
      setAppliedColors(colorsFromParams.split(","));
    }
  }, []);

  const onClickDiv = useCallback(
    (item) => {
      let updatedColors;
      if (appliedColors.includes(item)) {
        updatedColors = appliedColors.filter((color) => color !== item);
      } else {
        updatedColors = [...appliedColors, item];
      }
      setAppliedColors(updatedColors);

      // Cập nhật query param trên URL
      if (updatedColors.length > 0) {
        setSearchParams({ colors: updatedColors.join(",") });
      } else {
        setSearchParams({});
      }
    },
    [appliedColors, setSearchParams]
  );

  return (
    <div className="flex flex-col mb-4">
      <p className="text-[16px] text-black mt-5 mb-5">Colors</p>
      <div className="flex flex-wrap px-2">
        {colors?.map((item) => (
          <div key={item} className="flex flex-col mr-2">
            <div
              className="w-8 h-8 border rounded-xl mr-4 cursor-pointer hover:scale-110"
              onClick={() => onClickDiv(item)}
              style={{
                background: `${colorSelector[item]}`,
                border: appliedColors.includes(item)
                  ? "2px solid black"
                  : "1px solid gray",
              }}
            ></div>
            <p
              className="text-sm text-gray-400 mb-2"
              style={{ color: appliedColors.includes(item) ? "black" : "" }}
            >
              {item}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ColorsFilter;
