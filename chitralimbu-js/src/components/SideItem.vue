<template>
  <div class="accordion-item">
    <h2 class="accordion-header" v-if="item.isList === false">
      <router-link
        type="button"
        class="accordion-button collapsed no-arrow"
        :to="`/${item.link}`"
        >{{ item.title }}</router-link
      >
    </h2>
    <h2 class="accordion-header" v-if="item.isList === true" :id="item.title">
      <button
        class="accordion-button collapsed"
        type="button"
        data-bs-toggle="collapse"
        :data-bs-target="`#${item.title}-panel`"
        aria-expanded="false"
        :aria-controls="`${item.title}-panel`"
      >
        {{ item.title }}
      </button>
    </h2>
    <div
      v-if="item.isList === true"
      :id="`${item.title}-panel`"
      class="accordion-collapse collapse"
      :aria-labelledby="item.title"
    >
      <div class="accordion-body">
        <ul class="list-group list-group-flush">
          <li
            :key="index"
            v-for="(listItem, index) in item.subList"
            class="list-group-item"
          >
            <router-link :to="`${listItem.link}`">
              {{ listItem.subTitle }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "SideItem",
  props: {
    item: Object,
  },
};
</script>
<style scoped>
.no-arrow:after {
  display: none;
}
</style>
