<template>
  <nav>
    <!--    <ul>
      <li><router-link to="/">Home</router-link></li>
      <li><a href="#news">News</a></li>
      <li><a href="#contact">Contact</a></li>
      <li><a href="#about">About</a></li>
    </ul>-->
    <div class="side-nav">
      <form class="d-flex">
        <input
          class="form-control me-2"
          type="search"
          placeholder="Search"
          aria-label="Search"
        />
        <button class="btn btn-outline-success" type="submit">
          <i class="bi bi-search"></i>
        </button>
      </form>
      <div class="accordion">
        <SideItem
          :key="index"
          v-for="(item, index) in sidebar"
          :item="item"
        ></SideItem>
      </div>
    </div>
    <div style="margin-left: 25%; padding: 1px 16px; height: 1000px">
      <router-view />
    </div>
  </nav>
</template>

<style scoped>
body {
  margin: 0;
}
.side-nav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 25%;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

.no-arrow:after {
  display: none;
}
</style>
<script>
import SideItem from "@/components/SideItem.vue";

export default {
  name: "App",
  components: {
    SideItem,
  },
  data() {
    return {
      sidebar: [
        /*{
          title: "Title1",
          list: false,
          items: [],
          linkEnabled: true,
        },*/
        {
          title: "Title2",
          isList: true,
          subList: [
            {
              subTitle: "subTitle-1",
              link: "page1",
            },
            {
              subTitle: "subtitle-2",
              link: "page2",
            },
          ],
          linkEnabled: false,
        },
      ],
    };
  },
};
</script>
