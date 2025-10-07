import React, { useCallback, useEffect, useMemo, useState } from "react";
import { Link, useLoaderData } from "react-router-dom";
import Breadcrumb from "../../components/Breadcrumb/Breadcrumb";
import Rating from "../../components/Rating/Rating";
import SizeFilter from "../../components/Filters/SizeFilter";
import ProductColors from "./ProductColors";
import SectionHeading from "../../components/Sections/SectionsHeading/SectionHeading";
import ProductCard from "../ProductListPage/ProductCard";
import SvgCreditCard from "../../components/common/SvgCreditCard";
import SvgCloth from "../../components/common/SvgCloth";
import SvgShipping from "../../components/common/SvgShipping";
import SvgReturn from "../../components/common/SvgReturn";
import { useDispatch, useSelector } from "react-redux";
import _ from "lodash";
import { getAllProducts, getNewArrivals } from "../../api/fetchProducts";
import { addItemToCartAction } from "../../store/actions/cartAction";
import { loadNewArrivalProducts } from "../../store/features/product";
import { setLoading } from "../../store/features/common";

const extraSections = [
  { icon: <SvgCreditCard />, label: "Secure payment" },
  { icon: <SvgCloth />, label: "Size & Fit" },
  { icon: <SvgShipping />, label: "Free shipping" },
  { icon: <SvgReturn />, label: "Free Shipping & Returns" },
];

const ProductDetails = () => {
  const { product } = useLoaderData();
  const dispatch = useDispatch();

  const categories = useSelector((state) => state?.categoryState?.categories);
  const newArrivalProducts = useSelector(
    (state) => state.productState?.newArrivalProducts
  );

  const [image, setImage] = useState(product?.thumbnail);
  const [breadCrumbLinks, setBreadCrumbLink] = useState([]);
  const [similarProduct, setSimilarProducts] = useState([]);
  const [selectedSize, setSelectedSize] = useState("");
  const [error, setError] = useState("");

  const productCategory = useMemo(() => {
    return categories?.find((category) => category?.id === product?.categoryId);
  }, [product, categories]);

  // Load similar products
  useEffect(() => {
    getAllProducts(product?.categoryId, product?.categoryTypeId)
      .then((res) => {
        const excludedProduct = res?.filter((item) => item?.id !== product?.id);
        setSimilarProducts(excludedProduct);
      })
      .catch(() => {});
  }, [product?.categoryId, product?.categoryTypeId, product?.id]);

  // Load New Arrivals
  useEffect(() => {
    dispatch(setLoading(true));
    getNewArrivals()
      .then((res) => {
        dispatch(loadNewArrivalProducts(res));
      })
      .catch(() => {})
      .finally(() => {
        dispatch(setLoading(false));
      });
  }, [dispatch]);

  // Breadcrumb
  useEffect(() => {
    setImage(product?.thumbnail);
    const arrayLinks = [
      { title: "Shop", path: "/" },
      {
        title: productCategory?.name,
        path: `/category/${productCategory?.code}`,
      },
    ];
    const productType = productCategory?.categoryTypes?.find(
      (item) => item?.id === product?.categoryTypeId
    );
    if (productType) {
      arrayLinks.push({ title: productType.name, path: productType.name });
    }
    setBreadCrumbLink(arrayLinks);
  }, [productCategory, product]);

  // Add to cart
  const addItemToCart = useCallback(() => {
    if (!selectedSize) {
      setError("Please select size");
      return;
    }
    const selectedVariant = product?.variants?.find(
      (v) => v.size === selectedSize
    );
    if (selectedVariant?.stockQuantity > 0) {
      dispatch(
        addItemToCartAction({
          productId: product?.id,
          thumbnail: product?.thumbnail,
          name: product?.name,
          variant: selectedVariant,
          quantity: 1,
          subTotal: product?.price,
          price: product?.price,
        })
      );
    } else {
      setError("Out of Stock");
    }
  }, [dispatch, product, selectedSize]);

  useEffect(() => {
    if (selectedSize) setError("");
  }, [selectedSize]);

  const colors = useMemo(
    () => _.uniq(_.map(product?.variants, "color")),
    [product]
  );
  const sizes = useMemo(
    () => _.uniq(_.map(product?.variants, "size")),
    [product]
  );

  return (
    <>
      {/* Main Product Section */}
      <div className="flex flex-col md:flex-row px-10">
        <div className="w-full lg:w-1/2 md:w-2/5">
          {/* Images */}
          <div className="flex flex-col md:flex-row">
            <div className="w-full md:w-1/5 flex flex-col justify-center">
              {product?.productResources?.map((item, idx) => (
                <button
                  key={idx}
                  onClick={() => setImage(item?.url)}
                  className="p-2 mb-2 rounded-lg"
                >
                  <img
                    src={item?.url}
                    alt={idx}
                    className="h-14 w-14 object-cover rounded-lg hover:scale-105"
                  />
                </button>
              ))}
            </div>
            <div className="w-full md:w-4/5 flex justify-center">
              <img
                src={image}
                alt={product?.name}
                className="h-full w-full max-h-[520px] object-cover rounded-lg"
              />
            </div>
          </div>
        </div>

        <div className="w-full md:w-3/5 px-10">
          <Breadcrumb links={breadCrumbLinks} />
          <p className="text-3xl pt-4">{product?.name}</p>
          <Rating rating={product?.rating} />
          <p className="text-xl bold py-2">${product?.price}</p>

          <div className="py-2">
            <p>Select Size</p>
            <SizeFilter
              sizes={sizes}
              multi={false}
              onChange={(val) => setSelectedSize(val?.[0] || "")}
            />
            {error && <p className="text-red-600">{error}</p>}
          </div>

          <p className="text-lg bold mt-2">Colors Available</p>
          <ProductColors colors={colors} />

          <button
            onClick={addItemToCart}
            className="bg-black text-white px-4 py-2 mt-4 rounded-lg"
          >
            Add to Cart
          </button>

          {/* Extra Sections */}
          <div className="grid md:grid-cols-2 gap-4 pt-4">
            {extraSections.map((section, idx) => (
              <div key={idx} className="flex items-center">
                {section.icon}
                <p className="px-2">{section.label}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Product Description */}
      <SectionHeading title="Product Description" />
      <p className="px-8">{product?.description}</p>

      {/* Similar Products */}
      <SectionHeading title="Similar Products" />
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 px-10 py-4">
        {similarProduct.map((item) => (
          <ProductCard key={item.slug} {...item} />
        ))}
        {!similarProduct.length && <p>No Products Found!</p>}
      </div>

      {/* New Arrivals */}
      {newArrivalProducts?.length > 0 && (
        <>
          <SectionHeading title="New Arrivals" />
          <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 px-10 py-4">
            {newArrivalProducts.map((item) => (
              <ProductCard
                key={item.slug}
                title={item.name}
                price={item.price}
                thumbnail={item.thumbnail}
                slug={item.slug}
              />
            ))}
          </div>
        </>
      )}
    </>
  );
};

export default ProductDetails;
