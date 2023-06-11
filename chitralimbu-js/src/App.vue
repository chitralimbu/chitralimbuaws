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
    <div class="content">
      <router-view />
    </div>
  </nav>
</template>
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
        {
          title: "VueJs",
          isList: false,
          items: [],
          link: "about",
        },
        {
          title: "AWS",
          isList: true,
          subList: [
            {
              subTitle: "S3 web hosting",
              link: "page1",
            },
            {
              subTitle: "Presigned Url",
              link: "page2",
            },
          ],
          linkEnabled: false,
        },
        {
          title: "GraalVm",
          isList: true,
          subList: [
            {
              subTitle: "Native image",
              link: "page1",
            },
            {
              subTitle: "Tracing agent",
              link: "page2",
            },
          ],
          linkEnabled: false,
        },
        {
          title: "Java",
          isList: true,
          subList: [
            {
              subTitle: "Java8",
              link: "page1",
            },
            {
              subTitle: "Java11",
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

<style scoped>
body {
  margin: 0;
}

.content {
  margin-left: 250px;
}

.side-nav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 250px;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}
</style>
