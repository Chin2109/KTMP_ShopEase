import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useSearchParams } from "react-router-dom";
import { fetchCategoryType } from "../../api/fetchCategories";
import { loadCategoryType } from "../../store/features/category";
import { setLoading } from "../../store/features/common";

const Categories = ({ categoryName }) => {
  const categoryType = useSelector(
    (state) => state?.categoryState?.categoryType
  );
  const dispatch = useDispatch();
  const [searchParams, setSearchParams] = useSearchParams();
  const [selectedCategories, setSelectedCategories] = useState([]);

  // Lấy giá trị từ URL
  useEffect(() => {
    const categoriesParam = searchParams.get("categories");
    if (categoriesParam) {
      setSelectedCategories(categoriesParam.split(","));
    }
  }, []);

  useEffect(() => {
    dispatch(setLoading(true));
    fetchCategoryType(categoryName)
      .then((res) => dispatch(loadCategoryType(res)))
      .catch((err) => console.error(err))
      .finally(() => dispatch(setLoading(false)));
  }, [dispatch, categoryName]);

  const handleCheckbox = (name) => {
    let updatedCategories;
    if (selectedCategories.includes(name)) {
      updatedCategories = selectedCategories.filter((c) => c !== name);
    } else {
      updatedCategories = [...selectedCategories, name];
    }
    setSelectedCategories(updatedCategories);

    if (updatedCategories.length > 0) {
      searchParams.set("categories", updatedCategories.join(","));
      setSearchParams(searchParams);
    } else {
      searchParams.delete("categories");
      setSearchParams(searchParams);
    }
  };

  return (
    <div>
      {categoryType?.map((type) => (
        <div className="flex items-center p-1" key={type.id}>
          <input
            type="checkbox"
            id={type.code}
            name={type.code}
            checked={selectedCategories.includes(type.name)}
            className="border rounded-xl w-4 h-4 accent-black text-black"
            onChange={() => handleCheckbox(type.name)}
          />
          <label htmlFor={type.code} className="px-2 text-[14px] text-gray-600">
            {type.name}
          </label>
        </div>
      ))}
    </div>
  );
};

export default Categories;
