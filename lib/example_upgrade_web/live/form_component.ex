defmodule ExampleUpgradeWeb.FormComponent do
  use Surface.LiveComponent

  alias ExampleUpgrade.Cluster
  alias Surface.Components.Form
  alias Surface.Components.Form.ErrorTag
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.Label
  alias Surface.Components.Form.TextInput
  prop(cluster, :map, required: true)

  @doc "The action (:new / :edit) for the form"
  prop(action, :atom, values: [:new, :edit], required: true)

  @doc "The url to redirect to upon a successful submit"
  prop(return_to, :string, required: true)

  @impl true
  def update(%{cluster: cluster} = assigns, socket) do
    {changeset, _data} = cluster |> Map.from_struct() |> Cluster.validate()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cluster" => params}, socket) do
    {changeset, data} = Cluster.validate(params)
    {:noreply, assign(socket, changeset: changeset, data: data)}
  end

  def handle_event("save", %{"cluster" => cluster_params}, socket) do
    save_cluster(socket, socket.assigns.action, cluster_params)
  end

  defp save_cluster(socket, :new, _cluster_params) do
    {:noreply,
     socket
     |> put_flash(:info, "Cluster created successfully")
     |> push_redirect(to: socket.assigns.return_to)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <Form for={assigns.changeset} change="validate" submit="save" opts={id: "cluster-form"}>
      <Field name={:name}>
        <Label>Name</Label>
        <TextInput />
        <ErrorTag />
      </Field>


      <div>
        <button type="submit" theme="primary" phx-disable-with="Saving…">Save</button>
      </div>
    </Form>
    """
  end
end
