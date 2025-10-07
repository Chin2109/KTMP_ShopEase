import { useEffect, useMemo, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useSearchParams } from "react-router-dom";
import { fetchCategories } from "../../api/fetchCategories";
import { filterProducts, getAllProducts } from "../../api/fetchProducts";
import FilterIcon from "../../components/common/FilterIcon";
import Categories from "../../components/Filters/Categories";
import ColorsFilter from "../../components/Filters/ColorsFilter";
import PriceFilter from "../../components/Filters/PriceFilter";
import SizeFilter from "../../components/Filters/SizeFilter";
import { loadCategories } from "../../store/features/category";
import { setLoading } from "../../store/features/common";
import { clearFilterResults, loadFilterResults } from "../../store/features/product";
import ProductCard from "./ProductCard";
const ProductListPage = ({ categoryType }) => {
  const categoryData = useSelector((state) => state?.categoryState?.categories);
  const { filterResults, isFilter } = useSelector(
    (state) => state?.productState
  );
  const dispatch = useDispatch();
  const [products, setProducts] = useState([]);
  const [searchParams] = useSearchParams();
  const colors = {
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

  const sizeSelector = ["S", "M", "L", "XL", "XXL"];

  useEffect(() => {
    dispatch(setLoading(true));
    fetchCategories()
      .then((res) => {
        dispatch(loadCategories(res));
      })
      .catch((err) => {})
      .finally(() => {
        dispatch(setLoading(false));
      });
  }, [dispatch, categoryType]);

  const category = useMemo(() => {
    return categoryData?.find((element) => element?.code === categoryType);
  }, [categoryData, categoryType]);

  useEffect(() => {
    dispatch(setLoading(true));
    getAllProducts(category?.id)
      .then((res) => {
        setProducts(res);
      })
      .catch((err) => {})
      .finally(() => {
        dispatch(setLoading(false));
      });
  }, [category?.id]);

  const { searchResults, isSearching } = useSelector(
    (state) => state.productState
  );

  useEffect(() => {
    const hasFilterParam =
      searchParams.get("colors") ||
      searchParams.get("sizes") ||
      searchParams.get("categories") ||
      searchParams.get("priceMin") ||
      searchParams.get("priceMax");

    if (!hasFilterParam) {
      dispatch(clearFilterResults());
      // dispatch(clearSearchResults());
    } else {
      // Nếu có filterParam, gọi filterProducts
      const colors = searchParams.get("colors")?.split(",") || [];
      const sizes = searchParams.get("sizes")?.split(",") || [];
      const priceMin = searchParams.get("priceMin")
        ? Number(searchParams.get("priceMin"))
        : null;
      const priceMax = searchParams.get("priceMax")
        ? Number(searchParams.get("priceMax"))
        : null;
      const categories = searchParams.get("categories")?.split(",") || [];

      const fetchData = async () => {
        dispatch(setLoading(true));
        try {
          const data = await filterProducts({
            categoryType: categories.join(","),
            minPrice: priceMin,
            maxPrice: priceMax,
            color: colors.join(","),
            size: sizes.join(","),
          });
          dispatch(loadFilterResults(data));
        } catch (err) {
          console.error(err);
        } finally {
          dispatch(setLoading(false));
        }
      };
      fetchData();
    }
  }, [searchParams, dispatch]);

  // --- Chọn displayedProducts theo trạng thái ---
  const displayedProducts = isSearching
    ? searchResults
    : isFilter
    ? filterResults
    : products;

  return (
    <div>
      <div className="flex">
        <div className="w-[20%] p-[10px] border rounded-lg m-[20px]">
          {/* Filters */}
          <div className="flex justify-between ">
            <p className="text-[16px] text-gray-600">Filter</p>
            <FilterIcon />
          </div>
          <div>
            {/* Product types */}
            <p className="text-[16px] text-black mt-5">Categories</p>
            <Categories categoryName={categoryType} />

            <hr></hr>
          </div>
          {/* Price */}
          {/* <PriceFilter /> */}
          <hr></hr>
          {/* Colors */}
          {/* <ColorsFilter colors={Object.keys(colors)} /> */}

          <hr></hr>
          {/* Sizes */}
          {/* <SizeFilter sizes={sizeSelector} /> */}
        </div>

        <div className="p-[15px]">
          <p className="text-black text-lg">{category?.description}</p>
          {/* Products */}
          <div className="pt-4 grid grid-cols-1 lg:grid-cols-3 md:grid-cols-2 gap-8 px-2">
            {isSearching && searchResults.length === 0 && (
              <p className="p-8 text-gray-500">Không tìm thấy sản phẩm nào</p>
            )}
            {displayedProducts?.map((item, index) => (
              <ProductCard
                key={item?.id + "_" + index}
                {...item}
                title={item?.name}
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductListPage;
