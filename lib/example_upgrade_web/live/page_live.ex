defmodule ExampleUpgradeWeb.PageLive do
  use Surface.LiveView

  alias ExampleUpgrade.Cluster
  alias ExampleUpgradeWeb.FormComponent

  def mount(_params, _session, socket) do
    cluster = %Cluster{}

    {:ok,
     socket
     |> Surface.init()
     |> assign(:cluster, cluster)}
  end

  def render(assigns) do
    ~F"""
      <div>
      <h2>New Cluster</h2>
        <FormComponent
          cluster={@cluster}
          return_to={"/"}
          action={:new}
          id="cluster-new-form"
        />
      </div>
    """
  end
end
