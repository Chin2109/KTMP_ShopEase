// import React, { useState } from 'react'
// import RangeSlider from 'react-range-slider-input';
// import 'react-range-slider-input/dist/style.css';
// import './PriceFilter.css';

// const PriceFilter = () => {
//     const [range,setRange] = useState({
//         min:10,
//         max:250
//     })
//   return (
//     <div className='flex flex-col mb-4'>
//         <p className='text-[16px] text-black mt-5 mb-5'>Price</p>
//         <RangeSlider className={'custom-range-slider'} min={0} max={500} defaultValue={[range.min,range.max]} onInput = {(values)=> setRange({
//             min:values[0],
//             max:values[1]
//         })}/>

//         <div className='flex justify-between'>
//             <div className='border rounded-lg h-8 mt-4 max-w-[50%] w-[40%] flex items-center'><p className='pl-4 text-gray-600'>$</p> <input type='number' value={range?.min} className='outline-none px-4 text-gray-600' min={0} max="499" disabled placeholder='min'/></div>
//             <div className='border rounded-lg h-8 mt-4 max-w-[50%] w-[40%] flex items-center'><p className='pl-4 text-gray-600'>$</p> <input type='number' value={range?.max} className='outline-none px-4 text-gray-600' min={0} max="500" disabled placeholder='max'/></div>
//         </div>
//     </div>
//   )
// }

// export default PriceFilter

import React, { useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";
import RangeSlider from "react-range-slider-input";
import "react-range-slider-input/dist/style.css";
import "./PriceFilter.css";

const PriceFilter = () => {
  const [range, setRange] = useState({ min: 10, max: 250 });
  const [searchParams, setSearchParams] = useSearchParams();

  // Lấy giá trị từ URL
  useEffect(() => {
    const min = parseInt(searchParams.get("priceMin")) || 10;
    const max = parseInt(searchParams.get("priceMax")) || 250;
    setRange({ min, max });
  }, []);

  // Cập nhật URL khi thay đổi
  const handleRangeChange = (values) => {
    setRange({ min: values[0], max: values[1] });
    searchParams.set("priceMin", values[0]);
    searchParams.set("priceMax", values[1]);
    setSearchParams(searchParams);
  };

  return (
    <div className="flex flex-col mb-4">
      <p className="text-[16px] text-black mt-5 mb-5">Price</p>
      <RangeSlider
        className={"custom-range-slider"}
        min={0}
        max={500}
        value={[range.min, range.max]}
        onInput={handleRangeChange}
      />
      <div className="flex justify-between">
        <div className="border rounded-lg h-8 mt-4 max-w-[50%] w-[40%] flex items-center">
          <p className="pl-4 text-gray-600">$</p>
          <input
            type="number"
            value={range.min}
            className="outline-none px-4 text-gray-600"
            disabled
          />
        </div>
        <div className="border rounded-lg h-8 mt-4 max-w-[50%] w-[40%] flex items-center">
          <p className="pl-4 text-gray-600">$</p>
          <input
            type="number"
            value={range.max}
            className="outline-none px-4 text-gray-600"
            disabled
          />
        </div>
      </div>
    </div>
  );
};

export default PriceFilter;
