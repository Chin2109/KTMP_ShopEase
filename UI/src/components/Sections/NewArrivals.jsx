import { useEffect } from "react";
import Carousel from "react-multi-carousel";
import { useDispatch, useSelector } from "react-redux";
import { getNewArrivals } from "../../api/fetchProducts";
import ProductCard from "../../pages/ProductListPage/ProductCard";
import { setLoading } from "../../store/features/common";
import { loadNewArrivalProducts } from "../../store/features/product";
import { responsive } from "../../utils/Section.constants";
import "./NewArrivals.css";
import SectionHeading from "./SectionsHeading/SectionHeading";

const NewArrivals = () => {
  const dispatch = useDispatch();

  // Lấy danh sách New Arrivals từ Redux
  const newArrivalProducts = useSelector(
    (state) => state.productState?.newArrivalProducts || []
  );

  // Fetch New Arrivals khi component mount
  useEffect(() => {
    dispatch(setLoading(true));
    getNewArrivals()
      .then((res) => {
        dispatch(loadNewArrivalProducts(res));
      })
      .catch((err) => console.error(err))
      .finally(() => {
        dispatch(setLoading(false));
      });
  }, [dispatch]);

  return (
    <>
      <SectionHeading title="New Arrivals" />
      {newArrivalProducts.length === 0 ? (
        <p className="p-8 text-gray-500">Không có sản phẩm mới nào</p>
      ) : (
        <Carousel
          responsive={responsive}
          autoPlay={false}
          swipeable={true}
          draggable={false}
          showDots={false}
          infinite={false}
          partialVisible={false}
          itemClass="react-slider-custom-item"
          className="px-8"
        >
          {newArrivalProducts.map((item, index) => (
            <ProductCard
              key={item.slug + "_" + index}
              title={item.name}
              price={item.price}
              thumbnail={item.thumbnail}
              slug={item.slug}
            />
          ))}
        </Carousel>
      )}
    </>
  );
};

export default NewArrivals;
